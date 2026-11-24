Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C76606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KZOsZeqY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fTghfcqB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvnt-0006r1-6d; Tue, 24 Nov 2026 14:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnb-0006m3-TL
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:27 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnX-0006hQ-Of
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:26 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXU3j1618140
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TrzoLSKUiNwn3NY3gK2yBS9iuwVUTFQxQWhwNFsiQBY=; b=KZOsZeqYCGwCW/xt
 zKu3F44JrTmw+0m9Y7w9dP399oiuxuk6opKfFH++Ug0bcD6fetOVHRcuBwcuMehN
 /6nIijqdFTUI2ziABNVkifPJEW1AUkW8bq4zzAq6wDiWFAxpJ43P5ogLa0W09VeU
 b1bte5ns0wGb81X2mWJGXzT+9WPimkM+UD3YjqH/S5WlYx+d48gCyoPoxRMH+ZRB
 fHH9OBg5iPUdCv4oFbE9KzXcgJMTfbv8xyT9IaVoRUVgyfEfqtBhBWW34G4vnd84
 Xbbi1MQxV13Ev6MbQgEN9wAM+4M7L8jfj/tqoLr8N51bkTFhctVOFKK2l3aLis5w
 7E7pog==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky4d76-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:22 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-5641cd2cc13so5222031b6e.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795547001; x=1796151801; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TrzoLSKUiNwn3NY3gK2yBS9iuwVUTFQxQWhwNFsiQBY=;
 b=fTghfcqBPRuO6wxui4bA8+pPwUTv+GtOOnhzHna+iWFtW2nk5tGYnd4oeYr1TKrl0U
 vDv0n3NJ2LC8c4yx3Ge1/Whb0pnJ1sEhUx+C9bLkCIvASnzB0B2ppTgQhD7YXhxzU4B/
 T17/M0n3zZVF2bRHZCCdUuIRpGR8c23ZHD/ItXpRhR4HiLK9ISFDs/yJpqdiqDQT1/RK
 cgEYSoeTn1ugaWVJWsuJM1Pof5+pOSpQEysA29klHkCYH4H0ZYVvsAr8sp70/MvMbbq8
 Zksbsl46Bnnxyq+dWgSnQs6jUnFjFpDhuS3MoSr42YrqEEk77M8Vd9Il8NfJAh4yn8Tj
 hv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547001; x=1796151801;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TrzoLSKUiNwn3NY3gK2yBS9iuwVUTFQxQWhwNFsiQBY=;
 b=YTKXxbU6bm4Y8YF+tQrAZwdVV35i37tkHWHUqsrsl4MBp09khD0O5vOO/1zuzn0jiD
 VUuUNxV4BILOX4IGyhy3FCpWlqmue+c5dS9KvULlEmslIT5RF3bd5ce8Viwtns0wSqbx
 cSZQ2+jnn9jBAjp9e450mP+KYb2gcJz1E2fDUhWxsL9k/r6g/0MA8Jw7Fuv0+RC5Fetx
 /rNTJSJ9TXCxYTHCzGDm836vSbba3mymjlRZ+na5zb3u0REXRk0Fz2/CwPDiAEzQH615
 ZC11w+AgZAlONnjleob1KcWEtqBBiCEWP1J6FLfkEk0pS/boGpc7FnDOSwESh2zqjR02
 aCVw==
X-Gm-Message-State: APuU4Z/W2XG+zkl0dSEjmj0J7dLupvfIkEpz686m4NljFNWj+I7sN2S+
 SsnntExL1PGH8ljlJQ2ZU1cDvmtVpV6ddPpoMjGBoHutBai9D/a2e7kfvLVIQFr+/Amuh6GDYRf
 rtLklcNEyQmxoruaIvc9h1oYF2pYaHRucTevUPZoDDVClr3oDLGKW6nucoUYa9IgfSw==
X-Gm-Gg: AZFdTZeqycy0OvPE5ccCh4FjYv1lSvg3NozsuzXK3g6OpxXCLdTS+0FENbjiXSfdUXO
 /DBr96L5G4rPo3U00y5BaObhL0Sx0/VDRv9O8bCRgyXQKbEt/JK23CoBGDXemevQkKgKSiAMsmw
 UElCq/xNPQ4QZ7MKJbPrIAb3ZjoSMHX9QAGZA/Zz/sEZ8zFz5No5kvBlvCyCqtq4OgF2lohaAvk
 3iLzyian11YiqtbRfKRqrUl18qDE3UU9lPw07BbVTYYcc33mx88BjMK41LCXx+d1ml4/x10CKbm
 DWaavJeCCaHUs8vq3YTgaLqf067KH6BoqIcrqN+J27zDJn2W2hfVTgHtXulKTwEMOlHDIx2zaCL
 tlKb0tx7ouTsC5pt9x3dfwzDOHym8cI6T1e7zQF78QwzkwYiK/9fBVrl3Yj9n7tHfNV+GyJO3x8
 Gh2i8yVayZ6v8EEZ7REv6RVg==
X-Received: by 2002:a05:6808:4f06:b0:564:5fe0:dd76 with SMTP id
 5614622812f47-57a0a519228mr17816627b6e.18.1795547001328; 
 Tue, 24 Nov 2026 11:03:21 -0800 (PST)
X-Received: by 2002:a05:6808:4f06:b0:564:5fe0:dd76 with SMTP id
 5614622812f47-57a0a519228mr17816570b6e.18.1795547000753; 
 Tue, 24 Nov 2026 11:03:20 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a31929223sm12343195b6e.1.2026.11.24.11.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:03:19 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH-for-11.2 v3 2/7] target/hexagon: bound packet lookahead to the
 current page
Date: Tue, 24 Nov 2026 11:03:09 -0800
Message-Id: <20261124190314.3882017-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
References: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b05df7a cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=LOdbtK4x63e5lU4mKCMA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: iim9bnObNM8_92Qk7CFF4n_mklM11B4P
X-Proofpoint-ORIG-GUID: iim9bnObNM8_92Qk7CFF4n_mklM11B4P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX8tXo2QTlPIwA
 3EB/9b7fE9z0jYFg8ZJURMaDuzbjVknlRfAJ+n+qwQZ12hYdT7ZSEywdfnEP/HXo9cBcQkozkzV
 yIu8opzZtGj3ejMAbqfT4o+4882dqK0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX3r7NLSAraWyI
 BMWflT6ujM76Nfu5t9uP9JETIxT5IktyJynY91DhDp9zb8vCf3z/BFuGTPAvaC7fyqkJkrb5iQy
 uiveigpHECJ2/Uw3oFWP3fp8CxG+lBg9HkPaTSMkoB3Mk9dDV/JhIpnLzvtUHXXpWOTeJBX7w52
 EvxT3dZNsF0y+1rnSNM8S+wVcoI9Rpsle+1Gp3rX5i8uPHvvaloe+bvsGmic6vl6EM8m8My9C+X
 YcUE2D22PqKOv/ahky0FLdf4phlOeAjnBt64UMLX7R3yIB6GsKII+IV+9aDR+GrOaHwoSzjxkO6
 RN1sZod86d/hKH12E20WiFrm+67Bv/PbzeTB/ihoajhAo7zFuGMwN2Xw4Y731H5NsByKbTdBx3B
 X8jeptB5t+BsT9zlUK0hXlXZ2oIfTHh7531ri4y71vFlm718F6e6LufXTOkhWR6fBH5NhL7y3nP
 yo2hJOwZrz1K9AVkShg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KCkRvIG5v
dCBmZXRjaCBhbiB1bm1hcHBlZCBwYWdlIHdoaWxlIGRlY2lkaW5nIHdoZXJlIHRvIGVuZCBhIFRC
LgpUaGlzIGxldHMgY29tcGxldGUgcGFja2V0cyByZXRpcmUgYmVmb3JlIGEgc3RyYWRkbGluZyBw
YWNrZXQgZmF1bHRzLAphbmQgcHJlc2VydmVzIHRoZSBjb3JyZWN0IHBhY2tldCByZXN0YXJ0IGFk
ZHJlc3MuCgpTaWduZWQtb2ZmLWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVh
bGNvbW0uY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmll
ckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWlu
QG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCA1ICsr
KysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCAx
MWIzOTE3Yjk2Yy4uNzk2ZDMyYmZmOTUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0xNjIxLDYgKzE2MjEs
MTEgQEAgc3RhdGljIGJvb2wgcGt0X2Nyb3NzZXNfcGFnZShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
RGlzYXNDb250ZXh0ICpjdHgpCiAgICAgaW50IG53b3JkczsKIAogICAgIGZvciAobndvcmRzID0g
MDsgIWZvdW5kX2VuZCAmJiBud29yZHMgPCBQQUNLRVRfV09SRFNfTUFYOyBud29yZHMrKykgewor
ICAgICAgICAvKiBMb29rIGFoZWFkIG9ubHkgb24gdGhpcyBwYWdlOyBhIGZhdWx0IG11c3Qgbm90
IGRpc2NhcmQgdGhpcyBUQi4gKi8KKyAgICAgICAgaWYgKGN0eC0+YmFzZS5wY19uZXh0ICsgbndv
cmRzICogc2l6ZW9mKHVpbnQzMl90KSAtIHBhZ2Vfc3RhcnQgPj0KKyAgICAgICAgICAgIFRBUkdF
VF9QQUdFX1NJWkUpIHsKKyAgICAgICAgICAgIHJldHVybiB0cnVlOworICAgICAgICB9CiAgICAg
ICAgIHVpbnQzMl90IHdvcmQgPSB0cmFuc2xhdG9yX2xkbF9lbmQoZW52LCAmY3R4LT5iYXNlLAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+YmFzZS5wY19u
ZXh0CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKyBud29yZHMg
KiBzaXplb2YodWludDMyX3QpLAotLSAKMi4zNC4xCgo=

