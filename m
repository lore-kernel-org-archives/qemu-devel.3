Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D52606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QlNHpK3G;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QqnUH/LM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX2cF-0002rx-51; Fri, 27 Nov 2026 15:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX2cC-0002r4-Us
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 15:32:17 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xX2cA-0001QI-Si
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 15:32:16 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJBZpT2762929
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 20:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LO04MjDdnEpFcdOOGBvrUg
 e+LK2kbbTOGkSpmYsKZ6E=; b=QlNHpK3GMUtSwSdqV4BV31YnYLO8hIg6DATasA
 dq81M+7hefZpt1j/TlalBwNtKaF1SGCmDfrIO9zFFvji+CwybykOsCAlsMXZ43G3
 cXzIMer1Q/AOPHTcezrmgj+fSoSIAZz51iBFrkvqUtZeeFCxLnTU9GoxLDU2HECp
 uvREhDQZSqDiC4+VnU4Ae9YFeiPMvKUz36NZ/8gWHv09BCU7I90Oo9cm/9HU5pcg
 zGU8U7oqUctm5/ujwKi5d+4Rk5HOqKdRF+zRksuSje01cQArJHxS/tqNlG5t8+Ah
 ldUt8MhV0vZjsJtv149dC0D+G0MJFN/OiYuJAPbh/Simdakg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j756kaqjd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 20:32:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so12099904eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 12:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795811532; x=1796416332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LO04MjDdnEpFcdOOGBvrUge+LK2kbbTOGkSpmYsKZ6E=;
 b=QqnUH/LMRJpf74dzc3yfe3dGb/oExxpO0kvsCOFX4rCAncqLAyMdToC0bKjx7Aaegy
 L0J2zgH7hup8XK8WxJzWpKmkVjbpH2DZsVvZxM9XsLL+l6pNNQRLyKmPEKrZwdG1zpSA
 uuajyeOokq2UzJ+dK3ypOp6XboUi7xqT5oSSe36xlz0Dk0Y6qPows8LXebDRBszUYtu9
 0QPuU0fRZKZS3IlFPWaW0ROx82FRMJt2stOMXPM7fZJ8/DlTdOPKG8zZTMCUG9zjwe25
 mfblyeuwIAfqDMIBWH/NluMj3Q88ys5o9b06UKXHc3nxR+HAnSTW9ksQkBRJEBkARndn
 FUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811532; x=1796416332;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LO04MjDdnEpFcdOOGBvrUge+LK2kbbTOGkSpmYsKZ6E=;
 b=YVLsCmpZN9F8uqH6rlovV1bh+qe6JTqDpNX2balMcS+fyXuGEqm8ZEE9+3EG3rgDcf
 /paOZxmlVdu1rXkaq4CQWxWxyuyyqTmiAK1X/tSOhWs+oeVtxM7eBaGfVGNOHaAXjAzo
 CdP75Pow32gfM2FCcTfuk2q+b8qVFJ/Ds/xIo7Oc0SohgVnosLG6U3N8IJhL8wVPtv1R
 FIF5/QkVXODLWCyI4JZM1Dr6FActCyfgkuaXDkOuBhiLAv5O7ncIzqYZex5NrDgJqB64
 hlmTkjWg02gBKjJoGuNtqotlSwmWf7HmP7deJP6UHKNp+F+Kmk+FVrG5c1EGNK7yx9dJ
 434g==
X-Gm-Message-State: APuU4Z95x1X2Km/ru9btI1y76o5RCBHuxJVU5C5rNdHxKl7DftVtZsDM
 h4nihSNiQyaceTg+zdK200iZPd9pBDVIvhXYsTraZ4TyF24I9HtSErO3XOwFSlinVIqm4nFAo24
 H4yXuX7Gr8sUXQ3AyKdbjJimNrNjIn8SzIPTeVn6C5m4ArQ6MmhYiSE1n5aQZmb/g3Q==
X-Gm-Gg: AZFdTZfNyvpHwS5seY1ajr1XAHNsAj5CIdApX+36nKX5Uhz0cEeNcVCSvePCKlAds2P
 QEZyHQXy/YEoR1JDtrkpzKvKWP4MS3eRThKgdSofD9aEc6kaMQkA6L4ds+QWtshv6lLMuRXhdbv
 rtbok5qFCtK4Jebpq4di9ya8V8Jqp1qYyoF3mTD2Pu53JCnzc0A4FqP1Zvcxq1PtAHVyffM6fq2
 Wpl9vDvMbDs9XhUh8UL1FLLiYe/FHtKT8t5iyLBmz2OX9/XZ0KtpNw7D/8qtj1WasuGet12i37W
 amTT+HzAVLD4GHaN9H54nbuvSgWZuWvraCVHDi4sQJJU+KM356I5i2MivRtlOVkKqXPeOlNh9V4
 Gnqw42gpKe6HmNBcNH1h/pc/9PmdhyAxGArgIcJAwOO55amhOodh0e0nwgZFnV4HHf7cUjUKIqZ
 L0UOs4oJ8f/4lYuFINIMe8
X-Received: by 2002:a05:701b:4555:20b0:187:c940:21b9 with SMTP id
 a92af1059eb24-1b5568d53d4mr25020431c88.30.1795811531584; 
 Fri, 27 Nov 2026 12:32:11 -0800 (PST)
X-Received: by 2002:a05:701b:4555:20b0:187:c940:21b9 with SMTP id
 a92af1059eb24-1b5568d53d4mr25020395c88.30.1795811530632; 
 Fri, 27 Nov 2026 12:32:10 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55681301asm59248021c88.8.2026.11.27.12.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:32:10 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Ani Sinha <anisinha@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH for-12.0 v2 0/5] dump, hexagon: add support for cores
Date: Fri, 27 Nov 2026 12:32:04 -0800
Message-Id: <20261127203209.42752-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX6LcsumMkrJvf
 jNsza16961vTjBRmq+gehLEV/s3IAiHfSdN88RInJnPt0Dvhw/IU8zYPwgFKHX6YWkGb0FwuHx8
 C+NaTZfEmYOw05jhL99zFoTuBhZnlB+8rDpqzq0aYTyDhwv/7EiP36q2SSACVC1hbDOI+PDys13
 Tn5jS8dZCdDTy4hknq4PSdj4eJ1EChkbj8d7r9IyGWoStNzmz/AcdL3tUwElR0xOHL4DqIWW1Fi
 UWAJbkh3pccvteBnUETQ69aQVOK64cHuePGjM1SZzHrzV1JYb04C1xg5+c08/0kNwuGEZuhGnZ1
 qVcCSgTlqqATIXBQKHexPrtfFoOJ45t8BgYDlMmx+awurVoKtbF50Y0ENnzzlYUXAAhsDGZsyE1
 okCQgEe+mhpICx2f6a7Z1dNz+MfaIQpjJIiKrhTKZgjQhPlQmmrtx+30HlCm8eLhk4bXSCUmntY
 7Oo3u5Q417ZY9L40vPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX6D5U+Shz1+OG
 CDBFUEL4nbhmp41fPDK2d3vixaPdSuEhYpnoE4NVgSQpeMo2ztik2VAxVWoqmIh/q/I2Y0H4MAq
 cejBwayX1G1pJqBpObntX8k8Qf1Xtd4=
X-Authority-Analysis: v=2.4 cv=ebWo7LEH c=1 sm=1 tr=0 ts=6b09e8cc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BmgYcRIU7yPiCFNHKvoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: nwHpjg8R4wjY0xhPggvYGovAXSySBW_8
X-Proofpoint-ORIG-GUID: nwHpjg8R4wjY0xhPggvYGovAXSySBW_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QSBidWdmaXggYW5kIGltcGxlbWVudGF0aW9uIG9mIGNvcmUgZHVtcHMgZm9yIGhleGFnb24gbGlu
dXgtdXNlciBhbmQgc3lzZW11LgoKImZpeCBlX2Voc2l6ZSBpbiBFTEYgY29yZSBoZWFkZXJzIiBz
ZWVtZWQgbGlrZSBpdCBtaWdodCBub3QgYmUgYXBwcm9wcmlhdGUKZm9yIC1zdGFibGUsIHNvIEkn
dmUgbm90IHNwZWNpZmljYWxseSBhZGRlZCBpdCBhcyBhIENjL0ZpeGVzLiAgQ291bGQgaXQKY2F1
c2Ugc29tZSBpbmNvbXBhdGliaWxpdHk/ICBTZWVtcyBzYWZlciB0byBqdXN0IGxhbmQgaXQgZm9y
IGZ1dHVyZSByZWxlYXNlcy4KCkluIHYyOiByZXBsYWNlZCBgaWYgKCFjcHUtPnRsYilgIHdpdGgg
YXNzZXJ0aW9ucyBpbiAiZHVtcCB2ZWN0b3IgYW5kIHN5cwpyZWdzIGluIGNvcmVzIiBhbmQgInN1
cHBvcnQgRUxGIGNvcmUgZHVtcHMiLgoKdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUt
ZGV2ZWwvMjAyNjExMjUxOTQ4NTUuMzE1NDg0NS0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bS8KCkJyaWFuIENhaW4gKDUpOgogIGR1bXA6IGZpeCBlX2Voc2l6ZSBpbiBFTEYgY29yZSBoZWFk
ZXJzCiAgZHVtcDogbGV0IHRhcmdldHMgc2V0IGVfZmxhZ3MgaW4gdGhlIEVMRiBjb3JlIGhlYWRl
cgogIGxpbnV4LXVzZXI6IGxldCB0YXJnZXRzIGFkZCBub3RlcyB0byBjb3JlIGR1bXBzCiAgdGFy
Z2V0L2hleGFnb246IHN1cHBvcnQgRUxGIGNvcmUgZHVtcHMKICB0YXJnZXQvaGV4YWdvbjogZHVt
cCB2ZWN0b3IgYW5kIHN5cyByZWdzIGluIGNvcmVzCgogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFn
b25fdGxiLmggfCAgMTAgKysKIGluY2x1ZGUvc3lzdGVtL2R1bXAtYXJjaC5oICAgICAgIHwgICAx
ICsKIGxpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmggIHwgICA4ICsKIGxpbnV4LXVzZXIv
bG9hZGVyLmggICAgICAgICAgICAgIHwgICA5ICsrCiB0YXJnZXQvaGV4YWdvbi9jb3JlLWR1bXAu
aCAgICAgICB8ICA4OSArKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAg
ICAgfCAgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2ludGVybmFsLmggICAgICAgIHwgICA4ICsKIGR1
bXAvZHVtcC5jICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstCiBody9oZXhhZ29uL2hleGFn
b25fdGxiLmMgICAgICAgICB8ICAxNyArKysKIGxpbnV4LXVzZXIvZWxmbG9hZC5jICAgICAgICAg
ICAgIHwgIDE0ICsrCiBsaW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jICAgICB8ICAxNCArKwog
dGFyZ2V0L2hleGFnb24vYXJjaF9kdW1wLmMgICAgICAgfCAxMjUgKysrKysrKysrKysrKysrKwog
dGFyZ2V0L2hleGFnb24vY29yZV9ub3Rlcy5jICAgICAgfCAyNDMgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgfCAgMTcgKyst
CiB0YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICB8ICAgMiArCiAxNSBmaWxlcyBjaGFu
Z2VkLCA1NjAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0YXJnZXQvaGV4YWdvbi9jb3JlLWR1bXAuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9o
ZXhhZ29uL2FyY2hfZHVtcC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vY29y
ZV9ub3Rlcy5jCgotLSAKMi4zNC4xCgo=

