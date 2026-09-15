Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A195C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VLa-0003Sa-8T; Tue, 15 Sep 2026 11:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6VLY-0003SF-3b
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:45:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6VLU-0000B0-Ds
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:45:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFATg74176129
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 15:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=0nguLKjKq3Aupe3rT/YViZ
 TAUhJPsK9tVu7XlL7DL1U=; b=Qtbi0DlyyfSERdhj5dau+RBLFvS9k6w/H+botv
 LkPPc7bL3QPexMhYOnS9HaOz4tc4u2kEBkOt0byIqa0qwqcghZ3blIEXLQSSoTBl
 zVGxu6ytecnF7OB2jXjeNN31aQJ7PeJJBiVXZYSagpA+g2gzxnSmqS6eQgFb4DM0
 901h9X5rrAF6UEaPSRIakTzMVBGIWNnxCWCZbq7NA8/mOPoePOWdRqBiRTTf5AWO
 Ouh8dcv5yQSpJI+1DU+BTM8jjlVQoD7U8WgHUKQcSU4/KAFz3lGnwrQTIhkhkIoj
 hlC65MO6x4J3xPN7isSQ0jKRO8Z+ALfT3YZWP8gxolH5SWyA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc242b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 15:45:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d6f75c1219so94595645ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789487115; x=1790091915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0nguLKjKq3Aupe3rT/YViZTAUhJPsK9tVu7XlL7DL1U=;
 b=kmeKyRR+oUeZvuxhneR2hMhY+5DXwDAdcTpwJpMESLZhu/qkRSdDP9amMsbU4s7sAp
 okiBUao2iY2AHjxDtdy933p8PI4bLm+4c6Ar0bhHzAEDr5HXDaRtRYqKwG4Iy4tIxnYr
 m98Rmrc9r/hSpS05lAWiWD35G0PXXuQLpHaKRzNJsjiirGanSLjuk4Nj9imsVuhEOGdC
 psjiah+mu2SdTsM5wMXoNXxjH0pw0qJVnYJBNoYjZLPt8lWjc1hJUBos1sZJV5/DV5Ny
 t2oULrTx6/405GnbvAlfMBRAmoM+ldadYM7F7eZSPjOGNZzkcwuoeNbtFe9HwvA1zEEw
 LnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789487115; x=1790091915;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0nguLKjKq3Aupe3rT/YViZTAUhJPsK9tVu7XlL7DL1U=;
 b=sg6I25X4qEjI+1nnUGqnMPVV+rw8TSYsMJHKnAUwfEPDhR/qVuaPhCIGe6IQS7EQ6+
 A0ISUPam5v0F4UDSdmYo0bGDHK42YPDAUu8NstUqlGlK8vMCFfTiP6Pf1ngbkCXRfHFU
 jEa34Ts7olNONyaEWTk6zJbm+nVaT0AxyDxMVEC+Hhybc2briTTflrx+Ozil3+4XKUpk
 jVnzbhFUyVVWCXDW00VBFgaWi3wqjfip8UPYS017RRGzzXa0diZ9XTjAwFn+HixPaLbJ
 cwa+HndX1B/TrCg1aRhjinGPrtxC44kuCAnh6HpWdjKdu7/xQSWIAuqNbcF18IX4BGdk
 TKyg==
X-Gm-Message-State: AFuF++kFiuxdhyBHtfgD04+upVbWXHpVudMsdLltHmeRbXDDyzmB3+yl
 OcSeYQcWjBhPrPNgnBnGDLpJ+01AeY6L6urI50hYswcpU2TgDrXHJR6Y5Wxnqv3sDiw/TrQFRC3
 xYv9XB6EOHWCEP/oLr8f0yuZoDrJtBhQ1zUODvXoosRp3Lv9TFSg5L1/ynWOFftZXzw==
X-Gm-Gg: AYBFou29spum8HYwSBfnEJp41PIPfzHGRbyd6B5vnldDWGBQOMaPQdhuT9Yn3XcYXsS
 w1Wez5gdPM8li3avb16LFWeUHsTSj0gJcm+Oz7UNVXUAHS7C11M4BdmojmlZesRDmw7CHuXXW4S
 WayHBH1xHV/xXSne2wXaH20Zn7BMhmV9AOCZM+9FoeMvXtUiE0fcZYvPEHGq8wTzZNCQOePZkRD
 GquvIvBnKCL1zCB+leueZxtxLHkM0BRk2coTMR5jNoIKfIRgbbtqiGDNi5Q74eFp8nO8MZswlm/
 5v0popqPa1DN5PansHrsV90gQojYbdhIgFZWzCAihsBIwPSUn28DxAJFIjgKodFWTlfdcTdVXqQ
 VXSjRmZUZmHsZa+Hm+5C1zNn2RcPNwM/N7MbTYGhOo58i1SQZ
X-Received: by 2002:a17:902:c94f:b0:2dd:68a4:170c with SMTP id
 d9443c01a7336-2dd83851eccmr27662185ad.11.1789487115510; 
 Tue, 15 Sep 2026 08:45:15 -0700 (PDT)
X-Received: by 2002:a17:902:c94f:b0:2dd:68a4:170c with SMTP id
 d9443c01a7336-2dd83851eccmr27661515ad.11.1789487114922; 
 Tue, 15 Sep 2026 08:45:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cca264fsm72388495ad.11.2026.09.15.08.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:45:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 0/4] hexagon: Remove wait{,_next_pc}
Date: Tue, 15 Sep 2026 08:44:58 -0700
Message-Id: <20260915154502.4106597-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: eBtzUkRp9it0FNaQBRzF_vVMx7SPrwyG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzMCBTYWx0ZWRfX/9HDjWK1psEP
 Lur7padrpMF4ZaWc6wHYjMOftcy9Tt4auWYVSv4K6wc8jYyhaN3tGhxnXkvibeTQaI1ucUYrKRm
 op7SxyTyMafR9cKEVBGnMJXvTFKujls=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa9680c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=MtYhFM7dQAbplXO2xsQA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzMCBTYWx0ZWRfX7NgGE9eNcRkn
 ujMG/mL5fGQY7+1qrQ1VHVuGIXFgAdX6XIiO2bMrlVDx3q36wI88WmBP1CdLtag0taxnGGT96YS
 7mwIP2nDWROnUY2OcE3TyNfLBs1rfd9nfXRPOKdowc8EBzNz6z72a8Pvr+Q9lMkKsJqLfWbAkJn
 4u65oL/QIyxcU51GsDkcVmL6QWOQVMXzWlE0v+Ngv/ANPnoAdfXTsG0p8FVJehP5UhdbRKz6lSd
 RXFlSpQABKnHRWqUIqg7H3QUP/u+iKcRb3+qPMr05RXqXxQv9biw6epfztV+gw9axcHX2xVAmSC
 007HM1eocM7eBSY7HX65oDlvvDPov3taTHV4PhvTM3pLAxlhkGusl9H0WnOBu+3dt0+g1qfeHSi
 m4naFqG+N0aQmZeQaLI0ArkRqjG/alpjrk6KkXa5zJKmolFgc38VrlFbCmW6JG+aeLHALgHsTCC
 /G3TtBKEzJAWKuDJ9YA==
X-Proofpoint-GUID: eBtzUkRp9it0FNaQBRzF_vVMx7SPrwyG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150230
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

SGFuZGxpbmcgdGhlIFBDIHVwZGF0ZSBiZWhhdmlvciBmb3Igd2FpdCwgbG9ja2luZyBpbnN0cnVj
dGlvbnMsIENPRgpldGMuIHdhcyBtYW5hZ2VkIHdpdGggZXh0cmEgc3RhdGUuICBCdXQgaWYgd2Ug
cGFzcyB0aGUgY3VycmVudC1wYWNrZXQgUEMKdG8ge2swLHRsYn1sb2NrLCB0aGV5IGNhbiB1cGRh
dGUgUEMgd2hlbiBwZW5kaW5nLiAgQW5kIHByZWxvYWRpbmcgdGhlIFBDCndpdGggdGhlIG5leHQg
cGFja2V0IGFkZHJlc3MgYmVmb3JlIGV4ZWN1dGluZyBpbnN0cnVjdGlvbnMgdGhhdCBjb3VsZCBl
bmQKYSBUQiBsZXRzIHdhaXQoKSB1c2UgdGhlIFBDIGRpcmVjdGx5LgoKVGhpcyBzZXJpZXMgbWFr
ZXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuICBUaGUgYGJlc3R3YWl0YCB0ZXN0IGNhc2UsIHdoaWNo
CmV4ZXJjaXNlcyB0aGUgd2FpdCBpbnN0cnVjdGlvbiBhbmQgdGhlIGhhcmR3YXJlIHNjaGVkdWxl
ciBmZWF0dXJlIGhhcyBiZWVuCmFkZGVkLCBidXQgdGhpcyB0ZXN0IHBhc3NlcyBvbiB0aGUgYmFz
ZWxpbmUuCgpXb3J0aCBhIHNlY29uZCBvcGluaW9uOiB0aGlzIHNlcmllcyBtb2RpZmllcyB0aGUg
Q1BVIFZNU3RhdGVEZXNjcmlwdGlvbgpidXQgZG9lcyBub3QgdXBkYXRlIHRoZSB2ZXJzaW9uX2lk
LiAgSSBwbGFuIHRvIGNvbnRpbnVlIG1ha2luZyBjaGFuZ2VzIGFsb25nCnRoZXNlIGxpbmVzLCBs
ZWFkaW5nIHVwIHRvIHRoZSAxMS4yIHJlbGVhc2UuICBJIGhvcGUgdGhhdCBpdCdzIGFwcHJvcHJp
YXRlL3ZhbGlkCnRvIG9ubHkgdXBkYXRlIHRoZSB2ZXJzaW9uX2lkIHRvIGNhcHR1cmUgY2hhbmdl
cyBiZXR3ZWVuIHJlbGVhc2VzLCBub3QgbWVyZWx5CmNoYW5nZXMgYmV0d2VlbiBwdWxsIHJlcXVl
c3RzLgoKQnJpYW4gQ2FpbiAoNCk6CiAgdGFyZ2V0L2hleGFnb246IHBhc3MgdGhlIHBhY2tldCBQ
QyB0byB0aGUgazBsb2NrL3RsYmxvY2sgaGVscGVycwogIHRhcmdldC9oZXhhZ29uOiBzdGFnZSB0
aGUgUEMgaW4gdGhlIFBDIHJlZ2lzdGVyLCBkcm9wIG5leHRfUEMKICB0YXJnZXQvaGV4YWdvbjog
ZHJvcCB3YWl0X25leHRfcGMKICB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb246IGFkZCBiZXN0d2Fp
dCBzeXN0ZXN0CgogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgfCAg
MiAtLQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaCAgICAgICAgICAgICAgfCAgMiArLQog
dGFyZ2V0L2hleGFnb24vaGVscGVyLmggICAgICAgICAgICAgICAgICAgfCAgMiArLQogdGFyZ2V0
L2hleGFnb24vaGV4X21tdS5oICAgICAgICAgICAgICAgICAgfCAgOSArKystLS0tCiB0YXJnZXQv
aGV4YWdvbi9zeXNfbWFjcm9zLmggICAgICAgICAgICAgICB8ICA0ICsrLS0KIHRhcmdldC9oZXhh
Z29uL3RyYW5zbGF0ZS5oICAgICAgICAgICAgICAgIHwgIDIgLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jICAgICAgICAgICAgICAgICAgICAgIHwgIDIgLS0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxw
ZXIuYyAgICAgICAgICAgICAgIHwgIDggLS0tLS0tLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMg
ICAgICAgICAgICAgICAgICAgfCAxNCArKystLS0tLS0tLQogdGFyZ2V0L2hleGFnb24vaGV4X2lu
dGVycnVwdHMuYyAgICAgICAgICAgfCAgNCArLS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMg
ICAgICAgICAgICAgICAgICB8IDE1ICsrKysrKy0tLS0tLQogdGFyZ2V0L2hleGFnb24vaGV4c3dp
LmMgICAgICAgICAgICAgICAgICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jICAg
ICAgICAgICAgICAgICAgfCAgMiAtLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAg
ICAgICAgICAgfCAyNCArKysrKysrKystLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuYyAgICAgICAgICAgICAgICB8IDI5ICsrKysrKysrKysrKy0tLS0tLS0tLS0tCiB0YXJnZXQv
aGV4YWdvbi9oZXhfY29tbW9uLnB5ICAgICAgICAgICAgICB8ICA2ICsrKystCiB0ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSB8ICAzICsrKwogMTcgZmlsZXMgY2hhbmdl
ZCwgNTcgaW5zZXJ0aW9ucygrKSwgNzMgZGVsZXRpb25zKC0pCgotLSAKMi4zNC4xCgo=

