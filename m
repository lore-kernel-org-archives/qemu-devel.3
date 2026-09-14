Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A869BC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6FDs-0000fp-Vv; Mon, 14 Sep 2026 18:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6FDc-0000dM-QQ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:32:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6FDa-0006qV-UY
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:32:08 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYQJI1485156
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 22:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8ooTsCDYAQDQktBYGMxjuQ/5s/nm29muz942v31i4y8=; b=IWP7+aS6IZQYNkqu
 S3RQIrFQ9/jGyUJiGK0pSJfsftlGzr5haw8s+AvPyDvXTomMWQCWH0pMNn3VY8OL
 wXRIdicfnItw4ArJLCgcShDZRejV2d3xmv7wQsZaGbnyOFeo0wFqMy50FxR2r9yI
 0IHtSxHssurGE8JPrULv/DSUxNvz9LASgvV3X+dXiisA8y9jDqjmscTrD6nWvAaw
 9XVr1T5Ty/TMeyZGTYHN7VckWFy0F1HOt+/eAYIcbif/TpQckGxHZ+AXhel9121D
 TvTkKQjRj3TfmEjggcReUr18eNWf90Y4tKBRazl2blQ4IE9BuhpX5adz/vDsgsod
 533N4g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpg2ktjwv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 22:32:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d94f086fedso51986605ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789425124; x=1790029924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8ooTsCDYAQDQktBYGMxjuQ/5s/nm29muz942v31i4y8=;
 b=J5mBXUuaHl6y6muhar+SkWkPiKj+yT9gElw+x0tLT3/Ilbl34949rBppWRSYnkVp9V
 FIuLXvoCPNe7Z6B/HMGTliXPmO5Nj3faUZyPBRpvnIZt/SLFK6XuACduBVysr1W0aJ/0
 gjjitBTDUY61At97dcN93FudZ4m5ZVY9f9hlAlyVYmfi47zDXYfDOByChxuGOH00flaA
 0zuQ9VuBW2vZD4KFJg/k9lACzukg7NIo/1PTdgiL3RwtityXR20YUCigfA0niV1tUmns
 dIzzD34Rqhn1SZOtIbH74WWiMTPx2OIzr+hXvSJ/ZoW3D499L0VigvkscEt+lGfWR2E5
 3E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789425124; x=1790029924;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ooTsCDYAQDQktBYGMxjuQ/5s/nm29muz942v31i4y8=;
 b=h0XeF7hdqeKut+wHg6V187DnjjFae6sv4wUhTXZixCW5EeRPLW6P6lz0KOIsDdAQW+
 2Jx907whunIMWXXqoeHcoO+0XgUj9RuxzuhGsbQUIp/y/R9wl+b+vWMEgL7RvjiB4DE5
 aCIB+OxLYDSNLz2SC7RTE7MhrE8TMy1Ng9QnG7zt/ekiKVOHiSgwRs6JrZr9mvL7OyOw
 nQLgdw7Ww4mqOUw3jHkrT6O5ynGUvh9UVwsTLMsZwDZHQPc2pu6vnifUrx+UQUlQT0+Y
 9J2EUStoWg9J0GHzUh0ohQT8cMc7cbH6oC7txv52RSCSGlcDyc7mkwG2wCUQO7cO3XvF
 +s+w==
X-Gm-Message-State: AFuF++mFl0levZrw5c644NFfnZ6FrJUG+DVaBzBlYCJebgL/TUyYEKMN
 znu+zcZMir4jsvVEbbX8kn6Dewb6Ae/pRbqR65KeW73cc4uViRl8LDFv7VqBpB0YuVqzZU+LvuQ
 16LZpsezCjbpopy/MkKBXYPXehJNiupQ96g0t32P2jDnMy6OcNoGRhRz8729A7DAMHg==
X-Gm-Gg: AYBFou2N2AMUWHkwYiD0+2JpdnD82BdKIZQqfFmEEpz0bwpd007ZoLtEsqvWP0cqsUd
 IIsJKlOh8Xe6p4ypDS8SbHYWpI8iWM2Dc05rAM4QepJ/B5jU209fVvTQl9rIO9GBt9v+AmcCPrj
 lERKiCiPxlUkR5oc5xgKJbHf53/tOGwxymfkl0mGHr3QBZmwwZlSCltULLPOIAf5BInlc2eom5H
 mkuQ0uvwaSX0X42Rk44e7vYqxxLfU4gkj12krEz5l/irrTyV8VjHUwU6R4FqzOdruR3kDiN/gNj
 H+LRWPO1nPpijg7893bhunWka5q/DGvBz948+tVEFci/W9ocdsQE0uCZy81GhIN2GizyGVgGWXD
 oopPWdIdCx09VSzAov1DdH+VV9cm+uXOO0z83m67VJqwkCiUb
X-Received: by 2002:a17:902:fc44:b0:2da:e67a:87d4 with SMTP id
 d9443c01a7336-2dd6c75e064mr97760285ad.19.1789425124406; 
 Mon, 14 Sep 2026 15:32:04 -0700 (PDT)
X-Received: by 2002:a17:902:fc44:b0:2da:e67a:87d4 with SMTP id
 d9443c01a7336-2dd6c75e064mr97759535ad.19.1789425123861; 
 Mon, 14 Sep 2026 15:32:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba7a9bb56sm30190753eec.31.2026.09.14.15.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 15:32:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org
Subject: [PATCH v2 2/4] target/hexagon: fix semihosting STAT filename handling
Date: Mon, 14 Sep 2026 15:31:57 -0700
Message-Id: <20260914223159.2735262-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914223159.2735262-1-brian.cain@oss.qualcomm.com>
References: <20260914223159.2735262-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: VmobspjDbRYP2Uhbpe8vfu57rRZw-d_k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMyMiBTYWx0ZWRfX56oV2jofnbiu
 GRJy+iw3jd59JA5kYvcPdnToDTR2+dfVmRTo7l+0RLLghjmDYpCrlAE6ADb8zEcse3N1zw8koab
 /uQpT5F7arY3+7vzev1Y+woILzXeoxAbxrJTDmN/XpjtIw0x0KY5AvswCb9JldwYPDC8nFfCRxI
 oCXkyYVRATjTYcqOIUITrsQV2CgcUBEdWQ9es63ebmn5YFTrDERb9n5zqtKfvV+Qiy28gZmeQEx
 0/G4aQoXyeyvejnHSDDUsNX0pOQFb53todcjr12ox1ryTYh9JNdDj7uuiYfYe8Qr8U2GTFX0IHg
 8Pffa3GfN/azX4KvaNzPDC/dxvwICVL/V6evZlS5BAV0og48rOhUsgaWEezVgFMjFp/DT3ALoZD
 aabn8TOJCm681Wm2pzx/zTJnvGjNG2RgbxWJFnppPnhiKEIAQBicweSm10trJSaEzx0KZIdrJlA
 31vEcBhSqFXZA8ikfIg==
X-Proofpoint-GUID: VmobspjDbRYP2Uhbpe8vfu57rRZw-d_k
X-Authority-Analysis: v=2.4 cv=M7TYuCws c=1 sm=1 tr=0 ts=6aa875e5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=vVSmPHnlUJunR1QNDXkA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMyMiBTYWx0ZWRfX/qIsZN79esOG
 OgpHEF+MpzgADBlNv6jnuKIezTKWd5g4g2gVspDRna+IawH/2vj0mZiYkXDCH/ZiCu/Ab6qzQoK
 XhjQSFbjUUDzQZmDeuS2/XEXAwM0fho=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140322
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SEVYX1NZU19TVEFUIGNvdWxkIHBhc3MgYW4gdW50ZXJtaW5hdGVkIGxvY2FsIGZpbGVuYW1lIGJ1
ZmZlciB0byBzdGF0KCkKd2hlbiB0aGUgZ3Vlc3Qgc3RyaW5nIGZpbGxlZCBpdC4gVXNlIGxvY2tf
dXNlcl9zdHJpbmcoKSB0byBtYXAgdGhlIGd1ZXN0CnN0cmluZyBzYWZlbHkuCgpGaXhlczogNzcx
MWZkYmE4OGIgKCJ0YXJnZXQvaGV4YWdvbjogYWRkIG1haW4gYXJjaC1zcGVjaWZpYyBzZW1paG9z
dGluZyBvcGVyYXRpb25zIikKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBRkVB
Y0E5TU9zNlZmSGYyVUhaOHo0Y2R2YUIrN0RZNmhKYjJlbVlaMmFMU2UtdDZpd0BtYWlsLmdtYWls
LmNvbS8KU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+ClJldmlld2VkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyB8IDE0ICsrKysrKystLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2hleHN3aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKaW5kZXggMjFl
NWQ2MzBhNzUuLmQwYmExMTYyYTVkIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhzd2ku
YworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwpAQCAtNTUxLDIwICs1NTEsMjAgQEAgc3Rh
dGljIHZvaWQgc2ltX2hhbmRsZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAg
c3RydWN0IHN0YXQgc3RfYnVmOwogICAgICAgICB1aW50OF90ICpzdF9idWZwdHIgPSAodWludDhf
dCAqKSZzeXNfc3RhdDsKICAgICAgICAgaW50IHJjLCBlcnIgPSAwOwotICAgICAgICBjaGFyIGZp
bGVuYW1lW0JVRlNJWl07CisgICAgICAgIGNoYXIgKmZpbGVuYW1lOwogICAgICAgICB0YXJnZXRf
dWxvbmcgcGh5c2ljYWxfZmlsZW5hbWVfYWRkcjsKICAgICAgICAgdGFyZ2V0X3Vsb25nIHN0YXRC
dWZmZXJBZGRyOwogICAgICAgICBoZXhhZ29uX3JlYWRfbWVtb3J5KGVudiwgc3dpX2luZm8sIDQs
ICZwaHlzaWNhbF9maWxlbmFtZV9hZGRyLCByZXRhZGRyKTsKIAogICAgICAgICBpZiAod2hhdF9z
d2kgPT0gSEVYX1NZU19TVEFUKSB7Ci0gICAgICAgICAgICBpbnQgaSA9IDA7Ci0gICAgICAgICAg
ICBkbyB7Ci0gICAgICAgICAgICAgICAgaGV4YWdvbl9yZWFkX21lbW9yeShlbnYsIHBoeXNpY2Fs
X2ZpbGVuYW1lX2FkZHIgKyBpLCAxLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJmZpbGVuYW1lW2ldLCByZXRhZGRyKTsKLSAgICAgICAgICAgICAgICBpKys7Ci0gICAgICAg
ICAgICB9IHdoaWxlICgoaSA8IEJVRlNJWikgJiYgZmlsZW5hbWVbaSAtIDFdKTsKKyAgICAgICAg
ICAgIGZpbGVuYW1lID0gbG9ja191c2VyX3N0cmluZyhwaHlzaWNhbF9maWxlbmFtZV9hZGRyKTsK
KyAgICAgICAgICAgIGlmICghZmlsZW5hbWUpIHsKKyAgICAgICAgICAgICAgICBzZW1pX2NiKGNz
LCAtMSwgRUZBVUxUKTsKKyAgICAgICAgICAgICAgICBicmVhazsKKyAgICAgICAgICAgIH0KICAg
ICAgICAgICAgIHJjID0gc3RhdChmaWxlbmFtZSwgJnN0X2J1Zik7CiAgICAgICAgICAgICBlcnIg
PSBlcnJubzsKKyAgICAgICAgICAgIHVubG9ja191c2VyKGZpbGVuYW1lLCBwaHlzaWNhbF9maWxl
bmFtZV9hZGRyLCAwKTsKICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgIGludCBmZCA9IHBo
eXNpY2FsX2ZpbGVuYW1lX2FkZHI7CiAgICAgICAgICAgICBHdWVzdEZEICpnZiA9IGdldF9ndWVz
dGZkKGZkKTsKLS0gCjIuMzQuMQoK

