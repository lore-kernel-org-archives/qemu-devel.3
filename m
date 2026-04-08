Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CAE10F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsZ-0000p2-KV; Wed, 08 Apr 2026 14:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXsW-0000PE-Jx
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:43:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKP2-0005bK-Nb
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637J76Iq263766
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +uVDGq7dJHTrOrLyDMjlzrACmQcLWLNq2nBzhTxQpEs=; b=K9j3LxiK3f9tJoTt
 uZ8QbdbjPiZoeAzoI40droraUnM/Yt9p7cXucdrgx7Xd9PTyXkRW8YDCY3xOE/PL
 dNu2GLkay/mLXzGETQEg6AZXWcbwhH2s60nw6IqsYa4dG+qI57QCKOfZ59h/CPkz
 3nM/y33/WQQBkSpIw4NhtRANhsD3lFFCy6Jn8p9S5L7zzq9ypCeNYizNvKRED0xo
 31Lx4+elzf1FsOXGJjVfOHDCcScLJ/21ih95ij8cjAY4NwmEH+Cptzy0qTbbg8sc
 Ix9NAkQlf9mVvqsVF8ctiWJycXH1eqvB+Ax+ft8+Upz4pS0CBPfbk6IljXKWQOcH
 cu+IYQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7t21f4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:27 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-126e8ee6227so9485940c88.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622027; x=1776226827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uVDGq7dJHTrOrLyDMjlzrACmQcLWLNq2nBzhTxQpEs=;
 b=MLeAcNSHHIvqrDcJFHm8UVSqlS+jE53+ffWpbtOPqe2CnKo7N8L3KaMsZEd1EoR6Nr
 HKx2BlJxiGVTOqmLYFX/zCO8U7sZMkcF8RTGvHviEK+ibIhEz83Y+ZNt3VcktuYwrgE9
 1qOMAf5YRpaiLLmlAUUJphvtofP75WqBAZvuFkI2IyyEUK9a0GD0LqthbeBprTG5vuKr
 6lvObONFUCSa7DbN2w0bMbf0aZPqMh/Bf4jfV/8cpDb5brYfcSAFzhQuSpzsNwjmXg1P
 gjJJp8AWL33NQARfb5Uf1G976KJl0A6ixfrZ+cJNKTE7G2WkKIjDvMQagtXcTBh4rnbO
 zRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622027; x=1776226827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+uVDGq7dJHTrOrLyDMjlzrACmQcLWLNq2nBzhTxQpEs=;
 b=mAPVhgjW84ifA83vVs+sKzU6HGp3p/XOn/qZsB7+e98bh3SpvOk4yTeX7U6TuYfRcT
 7BINwLGqLKDlQ9uDjTsuewEc183PK/sJdLBVJteP0c+gCLmrgKKvsftSnpNUz7/63ZkH
 5agw9R9gbF+DYt60JAIp2i9hrFvsER3Qi+2iafWQk8LAA6oMSLm6cNe3hm3Y6l0O8j5D
 cYEekUr/bm7PcPeZl/JuhXxJKNECWI2Go5uPkk20u+dK6fu5kWp2VaXeG0brN76Zk9Gu
 K3Sfzou1gLh6NhGpRxqxViilHdNqHlcMN8pyrYUCWvTZtaIxVor9W+H+v2WU5FQDQNRE
 H8pA==
X-Gm-Message-State: AOJu0YyH5REcJSB+QabDsfJ9L3WvcChrdce//cgxVa3BB15O9Dk0rB1G
 Mvau+jvclVfs4ex002bcOejeZp6bymleIbFftFUkzZxKCce+QDw8APb4OZjQzxImNAWBIkqfReD
 jJVEPa/0Z7FKEjR7COb4+NacNNCVmpegFii8H6M94/MutAI3ra74xdvhp0kF0wNbhng==
X-Gm-Gg: AeBDievB/p1I6tvrK5xGnceoFFWWexf33qLk2QVj2phKsAEWt6BEpHIyCkRuzIKgyM+
 TGN8BH6qEVrZ69zILs6jP5cOf8KIU+RLIWJfrpvBs6pChcibw3EYJ062x/Hn8nRWaj7Pm5qOtdp
 /dvzc8Fdh1VK3V5IEsiYStXxdDfE4t3i0DVGoAUi9e6dLhr5uyLSHmgVpvKFBnrlLD0Y/mDGK07
 sg9HSmQBDkcJDsRbQdzhSr5u4PRElvUtviU3c5NmS9vi0Axmkr45iP2jHCCIce7fZUkTRZxJTDR
 dy4vuuz/U2uY2M9n8SOMVJHdyhRRDcpKKVJUYW3acycfT4bIJVxC5ZZp6C4k1oTzhUo2PUC/sYv
 svvHfArhHZQY5sqq9aqNVNEsQCwNwYHmtnFoUhK36ZvlnhShEE+pthh/ibIfKza0gLaJmHg==
X-Received: by 2002:a05:7022:52b:b0:11a:fec5:d005 with SMTP id
 a92af1059eb24-12bfb6fb407mr9528524c88.10.1775622026617; 
 Tue, 07 Apr 2026 21:20:26 -0700 (PDT)
X-Received: by 2002:a05:7022:52b:b0:11a:fec5:d005 with SMTP id
 a92af1059eb24-12bfb6fb407mr9528506c88.10.1775622025946; 
 Tue, 07 Apr 2026 21:20:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 18/28] target/hexagon: Decode trap1, rte as COF
Date: Tue,  7 Apr 2026 21:19:43 -0700
Message-Id: <20260408041953.1899532-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=De0nbPtW c=1 sm=1 tr=0 ts=69d5d78b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oDs3gbQtVgqjpHJ5GUgA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX3l35vT6PRG/l
 +8vY1o6iTMLx9ja8txY3exJGb/P0Nnt6OnhJCq4Qnyp+PSaM9KVJAueS9O9YbO5c/f0RsKYv/vj
 TE4jJR2/bH/6/wY33fT1zB+Ju5ePUK2bc6OtjZ2J85LLQwrex3vMRODvTQ7omfWlE8K2SHoXZKb
 ANaJKEGyECQM45k+0DFE8cwhJu4vCiYu6QdHiLC54mGagSKL4kxRHds604pvXIkcK0QKufhBKcs
 E0b6yOR98sJ7WUBrpXEYT8NWfez+fERQJJx+dWb19n33drF8DwO7Ut6b8RAFqeRaur01HcQfRcs
 MftDlBP+qIsKiEaTzfQ1cZD9Ntnho+gLxYE6kfBKvWTmaasaVSkzSibMAT5FYzSNtrOXUwoR2P6
 HAUo/e636nI3JNYMlEBbu5duQfT9N9pAnvqQYSvF4/2gb9rM5JveDykdN4ZoHaIlynw3AGOWEEG
 zV5gWvFFh/v/6LcFuvw==
X-Proofpoint-ORIG-GUID: q9UjJfaAU7dE1lkFhgYX8xcunRBlQ572
X-Proofpoint-GUID: q9UjJfaAU7dE1lkFhgYX8xcunRBlQ572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBbHNvOiBoYW5kbGUgcnRlIGlu
c3RydWN0aW9ucyBhdCB0aGUgZW5kIG9mIHRoZSBwYWNrZXQuCgoKUmV2aWV3ZWQtYnk6IFRheWxv
ciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9k
ZWNvZGUuYyB8IDE0ICsrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0L2hleGFn
b24vZGVjb2RlLmMKaW5kZXggZGJjOWM2MzBlODIuLmNlOTNlNmJkZDhmIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9kZWNvZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpAQCAt
MTg1LDYgKzE4NSw4IEBAIHN0YXRpYyBib29sIGRlY29kZV9vcGNvZGVfY2FuX2p1bXAoaW50IG9w
Y29kZSkKICAgICBpZiAoKEdFVF9BVFRSSUIob3Bjb2RlLCBBX0pVTVApKSB8fAogICAgICAgICAo
R0VUX0FUVFJJQihvcGNvZGUsIEFfQ0FMTCkpIHx8CiAgICAgICAgIChvcGNvZGUgPT0gSjJfdHJh
cDApIHx8CisgICAgICAgIChvcGNvZGUgPT0gSjJfdHJhcDEpIHx8CisgICAgICAgIChvcGNvZGUg
PT0gSjJfcnRlKSB8fAogICAgICAgICAob3Bjb2RlID09IEoyX3BhdXNlKSkgewogICAgICAgICAv
KiBFeGNlcHRpb24gdG8gQV9KVU1QIGF0dHJpYnV0ZSAqLwogICAgICAgICBpZiAob3Bjb2RlID09
IEo0X2hpbnRqdW1wcikgewpAQCAtMzYzLDYgKzM2NSwxOCBAQCBzdGF0aWMgdm9pZCBkZWNvZGVf
c2h1ZmZsZV9mb3JfZXhlY3V0aW9uKFBhY2tldCAqcGFja2V0KQogICAgICAgICAgICAgYnJlYWs7
CiAgICAgICAgIH0KICAgICB9CisgICAgLyoKKyAgICAgKiBBbmQgYXQgdGhlIHZlcnkgdmVyeSB2
ZXJ5IGVuZCwgbW92ZSBhbnkgUlRFJ3MsIHNpbmNlIHRoZXkgdXBkYXRlCisgICAgICogdXNlci9z
dXBlcnZpc29yIG1vZGUuCisgICAgICovCisjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkK
KyAgICBmb3IgKGkgPSAwOyBpIDwgbGFzdF9pbnNuOyBpKyspIHsKKyAgICAgICAgaWYgKHBhY2tl
dC0+aW5zbltpXS5vcGNvZGUgPT0gSjJfcnRlKSB7CisgICAgICAgICAgICBkZWNvZGVfc2VuZF9p
bnNuX3RvKHBhY2tldCwgaSwgbGFzdF9pbnNuKTsKKyAgICAgICAgICAgIGJyZWFrOworICAgICAg
ICB9CisgICAgfQorI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lkCi0tIAoyLjM0LjEKCg==

