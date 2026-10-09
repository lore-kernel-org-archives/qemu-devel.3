Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACABBCA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFGEJ-0007O6-GP; Fri, 09 Oct 2026 15:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGEE-0007NU-Eh
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:26:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGEC-0007eF-4b
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:26:02 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZWfW3584200
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 19:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xq9y0atm6Hwpw2Er27WmyYoW0KM+VqQjsEiPZLJpkpo=; b=D4FxZQPtWFDryuZJ
 MO5VgE6kqYam8OvbyC9cfAaTrJZU0GQspErGGJXpYVJrAw5uLEu/N11QlZ2XSRob
 tlTtj599s81EC2KnUumfHBJBV7LGrv6ZLsswehHK2r3tRCwvjRqZguIlNP0MtonL
 zF1sSJE/mZ/DstKfC9Wi3K+UCA0/tkO7A0Yjd6w4IQLOJcI6enQi4R1i+lhboipp
 hkEoT82SKIM/C+OxTVaiqW41IzjmHv62rW2QCNztJ+SKiiGru7dyz4b1hm7S2QJs
 fvHgr4pmIWRJeIEaKA3vvpSYeQr5KtAErb1V1CdIz10GkERKpLBCHjQ073OHBiEA
 FTmjpA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t70e92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 19:25:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so69932eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 12:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791573958; x=1792178758; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xq9y0atm6Hwpw2Er27WmyYoW0KM+VqQjsEiPZLJpkpo=;
 b=e0yov/eDEEteCv3ywu3nN9kURORGCFe3RMaOO32EaGIJgcen1PSboADASD9kEdIHVf
 u/eg7e2DSuL0U25rYcd7/ASov6b9hiahuE4BFaCVI167zKcBnI3IyLcwW6b7KUqMukg2
 cnhjsMH20O8KcgG5BOIsOiglGSC90Irls2ydeaxcVvCRcdz8g6dSox9W7F1zAXYz+Vqb
 VxZR5lEHpaYz6pGFQyTkmi5iKg5hYnu80PxOXhFk+cJCXskHM1xSCbla9lycMBrMaDNh
 qU7DGOtThc9yKLzvAso5LZQ+o1MpYS0V0/CBW1bqs43Y9DDEY0BL25QPk0Ps8PXrnNkU
 x41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791573958; x=1792178758;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xq9y0atm6Hwpw2Er27WmyYoW0KM+VqQjsEiPZLJpkpo=;
 b=e85XUpYVxUsXGJ6vVxCs6yXMJlXcvfj9UDWEkM+V+XAFgLyxuUdbYZ0tO+yrJyVnP8
 74+NevXWZ0O7XaoRtKeTUhbuu6bDPCZWbeo6vmsLBfVL6Y1b3plO0JI3uSSx0vR2Ybji
 tvWomHKW5hu2IPf1AcUngZ/BX9iK7GDRSIV0Kvjo5o2qv+w2KGIXxLnU2lS9k7rf7y5j
 vFrEA1XDukNogMfbPm7dqxvs2EOUu2E2kzs4i/HGbLxaHGv07VZUI37415xTnWVYzo6v
 i2Wor64/KExWIRNhDt85GGF9IaLDWFFHc/GfVV7umcYHxHxpDXRPDkMwOZdee/DLxi9S
 qQ1w==
X-Gm-Message-State: AFq9FYJWIoIZc0nXW14S2iEu1UBOqw6Am+QFGCGb5XAlN63zU1GFtdlg
 oIWbxd6mo8nuL8DNzA7HcJRYCoRZCbDeJCojKbcLW/RUe2cnJZGfMFF1KtkTU+D964XqtaQE1Zq
 ddM4rIdHs+J7qWkLfuuEy2vwJACEKexQV377zp0QmmiVufcWNJEgUNSzZUhwYzNDuWQ==
X-Gm-Gg: AYBFou2hQAZVuMh2s2/YuVzVC9FNkZlPpFiJKclAC++T6Z9WvSLUK/3usU5kKcf5BOr
 T0Do5MRTikDrCxOPA/aQ0xSurA8AekSL01UpvC8PebsduojcLhqHiCteaWsckADqnPXIIWaLk0g
 EdXxzATnd7Lky/XyPLrt2kACt3rbhvtaGy7pQfHbKTqPCpwzi9waYMUn8JEsD/d0YVhv0OZaNcH
 oO5+bxmnqmLQSeRWkRW+RskvrpVCrs6oPUhxVQ2Ka6XhINyrWglFu517emieHGOckWC7NY5hYce
 Az9G6Fd3zmFrLkpB5WtG2jTYG2Y36rkbX6yddYnVJxMjAI2te+ms8SzI95BNbnZZ8TeivaTr49G
 1IgHsEZ0H7x5nCSA82slvAozWSsirzi96r9vJE3r7v/ejxDU=
X-Received: by 2002:a05:7300:4706:b0:34e:3ce1:39f8 with SMTP id
 5a478bee46e88-3537e021d3cmr3921213eec.18.1791573957783; 
 Fri, 09 Oct 2026 12:25:57 -0700 (PDT)
X-Received: by 2002:a05:7300:4706:b0:34e:3ce1:39f8 with SMTP id
 5a478bee46e88-3537e021d3cmr3921185eec.18.1791573957157; 
 Fri, 09 Oct 2026 12:25:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm7652822eec.13.2026.10.09.12.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:25:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 6/6] tests/functional/hexagon: add MiniVM, lock tests
Date: Fri,  9 Oct 2026 12:25:40 -0700
Message-Id: <20261009192541.4163758-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: TL7i12PMleMy3KfMTIUzM4Y0PjTn1KM8
X-Authority-Analysis: v=2.4 cv=Mbr5KJ/f c=1 sm=1 tr=0 ts=6ac93fc6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=lxC5_JGnJAQX7-PTBzMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfX0y8R/fj3Zcrx
 J0c0XDl/i9nG4sdmhkd571m1ZXv6pRebmznC0chfYK1Y5Jf3NpHYKOl11wWOSdpHvcwyzDpUiZN
 nan3DSdjzyyMY9smvwxEf8QS0RuSoe4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfX6sWn68FifHeS
 bAbTFFCD2dBtycUe+ny6lPztydzgySUXoWGtnWW0dWeTNlyS3NyPjsTDMa+61A9n0fUynCLxqi8
 B3Xshvm/Tz03IE1HNtu5DGGfHFAVZgho2INmcLjGlhwH4JMnYE2ZEMT9DbSry370NOzNbih0+UC
 yqk8WFyeMfEdtx1UsSJ9ySA9pB3UhmrckYNzFd1gEMiJKzvyzwqQ3uHuVNNzIQ5NVxJzB32uTA5
 9Vb2TMMjNrbIJk459TGMnwh9LHJYq9ho9M9w+orYbKD9E9VGMC21or+fOomZmJGcHO1jL98b0MV
 5vFGIegszB3rlch76jEyvsPlU8pLHfzvSeLGeAG9Nt2ZTyxkUXNMizn+hTFSZlU6fYF8OW2mn/3
 o4SkLxxXCF3vgmeIQUtpV7uU1t3mIO81K8gejzbqSUKRNPD1H7ijCvONQwzEvgowxEuZve78G63
 rHsIlbSyuu7o5jIAgVA==
X-Proofpoint-GUID: TL7i12PMleMy3KfMTIUzM4Y0PjTn1KM8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090077
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QWRkIHRoZSBsb2NrX3ZlcmlmeSB0ZXN0IGNhc2UgdG8gdmVyaWZ5IHRoZSBrMC90bGJsb2NrIGJl
aGF2aW9yLCBhZGQgdGhlCm1pbml2bSB0ZXN0cyB0byBjb3ZlciBzdGFydCgpIGFuZCBtb3JlLgoK
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgIHwgIDEgKwogdGVz
dHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfbWluaXZtLnB5ICAgfCA0MyArKysrKysrKysrKysr
KysrKysrKysrKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgfCAg
MyArKwogMyBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA3
NTUgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfbWluaXZtLnB5CgpkaWZmIC0tZ2l0IGEv
dGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkIGIvdGVzdHMvZnVuY3Rpb25hbC9o
ZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IDQ0MDUzZTY0Njc2Li5lMTgyYmM5OGEwNiAxMDA2NDQK
LS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkCisrKyBiL3Rlc3RzL2Z1
bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtMyw2ICszLDcgQEAKIHRlc3RzX2hleGFn
b25fc3lzdGVtX3Rob3JvdWdoID0gWwogICAnYXJjaF90ZXN0cycsCiAgICdzeXN0ZXN0cycsCisg
ICdtaW5pdm0nLAogXQogCiB0ZXN0X2hleGFnb25fdGltZW91dHMgPSB7CmRpZmYgLS1naXQgYS90
ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9taW5pdm0ucHkgYi90ZXN0cy9mdW5jdGlvbmFs
L2hleGFnb24vdGVzdF9taW5pdm0ucHkKbmV3IGZpbGUgbW9kZSAxMDA3NTUKaW5kZXggMDAwMDAw
MDAwMDAuLmE3MGVkYmNjOTg3Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9o
ZXhhZ29uL3Rlc3RfbWluaXZtLnB5CkBAIC0wLDAgKzEsNDMgQEAKKyMhL3Vzci9iaW4vZW52IHB5
dGhvbjMKKyMKKyMgQ29weXJpZ2h0KGMpIDIwMjQtMjAyNSBRdWFsY29tbSBJbm5vdmF0aW9uIENl
bnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorIworIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgorCitmcm9tIHFlbXVfdGVzdCBpbXBvcnQgUWVtdVN5c3Rl
bVRlc3QsIEFzc2V0LCBza2lwQmlnRGF0YVRlc3QKKworY2xhc3MgTWluaVZNVGVzdChRZW11U3lz
dGVtVGVzdCk6CisgICAgJycnCisgICAgbWluaXZtIGlzIGEgSGV4YWdvbiBoeXBlcnZpc29yIHRo
YXQgaW1wbGVtZW50cyB0aGUgSGV4YWdvbiBWTQorICAgIHNwZWNpZmljYXRpb24uICBUaGVzZSB0
ZXN0IGNhc2VzIGJvb3QgbWluaXZtIGFuZCB0aGVuIGxvYWQgdGVzdCBjYXNlcworICAgIHRvIHRo
ZSBhZGRyZXNzIHNwZWNpZmllZCBieSBNaW5pVk1UZXN0LkdVRVNUX0VOVFJZIGFuZAorICAgIGV4
ZWN1dGUgYSBtaW52bS1ndWVzdCBwcm9ncmFtIHRvIGV4ZXJjaXNlIG1pbml2bSB2aXJ0dWFsaXph
dGlvbgorICAgIGZlYXR1cmVzLgorICAgICcnJworICAgIHRpbWVvdXQgPSAxODAKKyAgICBHVUVT
VF9FTlRSWSA9IDB4YzAwMDAwMDAKKyAgICBSRVBPID0gJ2h0dHBzOi8vYXJ0aWZhY3RzLmNvZGVs
aW5hcm8ub3JnL2FydGlmYWN0b3J5JworICAgIEFTU0VUX1RBUkJBTEwgPSBcCisgICAgICAgIEFz
c2V0KGYne1JFUE99L2NvZGVsaW5hcm8tdG9vbGNoYWluLWZvci1oZXhhZ29uLycKKyAgICAgICAg
ICAgICAgICcxOS4xLjUvaGV4YWdvbl9taW5pdm1fMjAyNF9EZWNfMTUudGFyLmd6JywKKyAgICAg
ICAgJ2Q3OTIwYjVmZjE0YmVkNWExMGIyM2FkYTdkNGViOTI3ZWRlMDg2MzUyODFmMjUwNjdlMGQ1
NzExZmVlZTJjMmEnKQorCisgICAgQHNraXBCaWdEYXRhVGVzdCgpCisgICAgZGVmIHRlc3RfbWlu
aXZtKHNlbGYpOgorICAgICAgICBzZWxmLnNldF9tYWNoaW5lKCdzaW0nKQorICAgICAgICBzZWxm
LmFyY2hpdmVfZXh0cmFjdChzZWxmLkFTU0VUX1RBUkJBTEwpCisgICAgICAgIHJvb3Rmc19wYXRo
ID0gc2VsZi5zY3JhdGNoX2ZpbGUoJ2hleGFnb24tdW5rbm93bi1saW51eC1tdXNsLXJvb3Rmcycp
CisgICAgICAgIGtlcm5lbF9wYXRoID0gZid7cm9vdGZzX3BhdGh9L2Jvb3QvbWluaXZtJworCisg
ICAgICAgIGZvciB0ZXN0X2Nhc2UgaW4gKCd0ZXN0X21tdScsICd0ZXN0X2ludGVycnVwdHMnLCAn
dGVzdF9wcm9jZXNzb3JzJyk6CisgICAgICAgICAgICB3aXRoIHNlbGYuc3ViVGVzdCh0ZXN0X2Nh
c2U9dGVzdF9jYXNlKToKKyAgICAgICAgICAgICAgICB2bSA9IHNlbGYuZ2V0X3ZtKG5hbWU9dGVz
dF9jYXNlKQorICAgICAgICAgICAgICAgIHZtLmFkZF9hcmdzKCcta2VybmVsJywga2VybmVsX3Bh
dGgsICctZGV2aWNlJywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBmJ2xvYWRlcixhZGRy
PXtoZXgoc2VsZi5HVUVTVF9FTlRSWSl9LCcKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBm
J2ZpbGU9e3Jvb3Rmc19wYXRofS9ib290L3t0ZXN0X2Nhc2V9JykKKyAgICAgICAgICAgICAgICB2
bS5sYXVuY2goKQorICAgICAgICAgICAgICAgIHZtLndhaXQoKQorICAgICAgICAgICAgICAgIHNl
bGYuYXNzZXJ0RXF1YWwodm0uZXhpdGNvZGUoKSwgMCkKKworaWYgX19uYW1lX18gPT0gJ19fbWFp
bl9fJzoKKyAgICBRZW11U3lzdGVtVGVzdC5tYWluKCkKZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0
aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29u
L3Rlc3Rfc3lzdGVzdHMucHkKaW5kZXggYzgxMzdhNzE3MTMuLjY3MDQzNDg4NjU3IDEwMDc1NQot
LS0gYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQorKysgYi90ZXN0
cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQpAQCAtMTA1LDUgKzEwNSw4IEBA
IGRlZiB0ZXN0X2h2eF9tdWx0aShzZWxmKToKICAgICBkZWYgdGVzdF9zdGFuZGFsb25lX3ZlYyhz
ZWxmKToKICAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJzdGFuZGFsb25lX3ZlYyIpCiAKKyAg
ICBkZWYgdGVzdF9sb2NrX3ZlcmlmeShzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJv
KCJsb2NrX3ZlcmlmeSIpCisKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICAgUWVtdVN5
c3RlbVRlc3QubWFpbigpCi0tIAoyLjM0LjEKCg==

