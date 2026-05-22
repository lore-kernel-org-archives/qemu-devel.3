Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A0DCD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXJi-0004Q2-FR; Fri, 22 May 2026 17:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wQXJe-0004PO-W9
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:21:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wQXJc-00034q-Lw
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:21:58 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MK2CPb1960694
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 21:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ex/2qrqWCNrz+WvjI0oVx7Ia/NbanTQ63h6H1q4AiNQ=; b=LJiXd8nAyyr5wrXA
 x++bGvzGcBJoQu6vwG2jfX1liCBkXztJos6MSU/ioxx3fK859G1joGe0lAZiR+dD
 XQO2wcRu+veSUW50QvaX4jA+FBhjqNy1AiUHa8JshF9nfbYVkRFUJHuw6lZrju6k
 swemCHM9OKrrhcenp+hnmqMdk29gf8FVTxZ8cvgl7lDePSaS6luucYZkr35MOygx
 AKuPK4uHmnxvHRhMW17aDkw6vzU7SbebahoXBKxjEoHvXDzvMa75FcgmTCpKte13
 Qtqr7NyeKMh4PdGnn0K9AnGWn6jatH8szed2jXVRMbpWHs0aKpI7NpBb1J+NY+8s
 Ek2E6g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eahxeucc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 21:21:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso9349156eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779484913; x=1780089713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ex/2qrqWCNrz+WvjI0oVx7Ia/NbanTQ63h6H1q4AiNQ=;
 b=SvvyFtKMqGjXoDkSMzdjgy6e34dExcGVjpFhD0uzQUUCu5upkdkUxAuzGlxhdTfUq7
 FqKkANuObKzpgDa0+rTlQR4ncNqE2lwxZyM2abrydiERCDJ4X5AWIwLQ01GJ/Eg565Q0
 sYYAhTe5igdL2D+VzXSe7hH6jpdUvjXXsyApryEg01Hg5Q11wE3hTcPsmxVsytDJReAZ
 lnZoFprCgKUSBOAtWDZnLehfK2Xg9cT8lC2dVHiN+LYQOa+qC2AOPN/otYteTGseI02V
 Oj2u5ORzb2IbC7iRF9+6f0nH+XWWvk925tib3f7ug76lnHuYGzLxTUmrS2XNxJQJihLo
 bZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779484913; x=1780089713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ex/2qrqWCNrz+WvjI0oVx7Ia/NbanTQ63h6H1q4AiNQ=;
 b=bOla6aGwm7m7xJihCrDjlodf01VRp5yXpSyjNlgME/qU5VM8MUKkzy96OQwin0JlLG
 Xt+6K6wAD/Fx3iTVdHSHEvGgxadFrIFrqLMS2tOUK0GHoVvN/Bo/n/GsqbNafJ3eMrg4
 25RtwNurkFOPeY8W9wKf6KuSXkZpbLEk9xz46lhCb2klDIyumnsY6FikFDzCneYyotA6
 vargEId/w8L3R+3c4iY2Bt04EwnFuFefD+VSqqrDSlWX3LU8Fc5cJ+EtGrsN0dfWK+o6
 mmre9xsAjoZ37hBpJO9PyyE3VNJomdmOZWcfTMSLyHTER8DhN840DRIQJjnVPFMjh3sB
 bi0Q==
X-Gm-Message-State: AOJu0YyLGL0dxO5kLBRHJ6831QBC4aJdB/pNdot9ZuPhb8B214+IDoDY
 52zsHu8UgIBI2JB4kHKg1cfZMFA+O3xlB7MBx4+6MarEZJKERpaIDz+zXfuF+zVWTD6UkTY/Am+
 ysH1C5UodVeby7GblvpDdwxBfCAO3TxzhVZRvucgZCow44MneZ64v9roc4n596AiPHQ==
X-Gm-Gg: Acq92OGpWQ8YCzhgb8Q4aGdI3ng2HsMTOi8RMz02YgfVKpYdI91qIhX1N0w4JBRw1yQ
 D9GHePc6ojh40z2dFRob9RR0k4JMv1rzqFpk6uCT1csueuM2iawHHKXbaHksgGQfCKpZJKikLD1
 zm0ul7YiLMk/1/lTEIG5SCglTNX4G/WnRmPbngUHxxwLsQB6rDM/J0FJqkaUrdpNqr1ATTVbtFb
 O806m+vah+dRFA3B5cYMKfoqrtUcCPlF8Ew8RXF9UtF7FGNhZZDPB1inUTRtG+tVh4GXl4qvXrl
 B8J3yAJLHRsmvs4tzgTU0YGjnt2kySFnv6ACSp0kWjetuo8z2ZOxibFsR/qBxEB51C4GwgOZHbw
 oVTXC3Q/X80f+OgbwLTSeqc/zblOWHcyC84e+k2iRndjCNzW2OGXCgqoMRcDZb5BAvmX+WBm9JR
 hOLWwJ
X-Received: by 2002:a05:7300:72cd:b0:2f5:3fb3:4a76 with SMTP id
 5a478bee46e88-30448f51997mr2903594eec.10.1779484913521; 
 Fri, 22 May 2026 14:21:53 -0700 (PDT)
X-Received: by 2002:a05:7300:72cd:b0:2f5:3fb3:4a76 with SMTP id
 5a478bee46e88-30448f51997mr2903571eec.10.1779484912967; 
 Fri, 22 May 2026 14:21:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045225b7b6sm3005755eec.25.2026.05.22.14.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 14:21:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, alex.bennee@linaro.org,
 berrange@redhat.com, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 2/2] tests/docker: Update hexagon cross toolchain to 22.1.0
Date: Fri, 22 May 2026 14:21:47 -0700
Message-Id: <20260522212147.3089295-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522212147.3089295-1-brian.cain@oss.qualcomm.com>
References: <20260522212147.3089295-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIxMiBTYWx0ZWRfX24HNfns1+TIc
 cfXY//DZ3bX2rd9YhNDV/Lf9Vm7hyIoVbPxed6vVmuCfIAhH7c+qqH2SK20Ugt8JjRh5+NQFUi3
 /0SUZZJqWGwYMVDpvj/THjC+quW8LPaOg6QTl9aR8ozwPBErquri87x2IsWvSYnKOg0+/HY3o2w
 HfHhv/t/6GI7EBa2m2MD9Z+ZFRjWVs/UhEdbDtUZ22dz9nYPtvKKsyPOu5bIev2PjmQY+4tMsl6
 lbVKnkGryz3W1xm5fPTwgJQQpQ6SHEjKQ0fVmZNdtqFAQxM2oEnYop5KtkFDGYndLVJAThzVWrR
 kcP7xq1IPP9fWZjT6peSF+3ROv7T9OEi2nr9G1KgT3htUl1E5Mciqim6r9uAJh/TlXNPd+7cYWg
 zWghPCQ5ckqq7emVHl3z9flF0DzxN2n4ivHsVgt7abn/DevYVTYCLzYPtCimC1/OJ0r5O26uVp/
 /51uDKXYxa8Q8xxuErQ==
X-Proofpoint-GUID: c5jMnVqbji8Ww_lit9ymiIulDc2msgXj
X-Proofpoint-ORIG-GUID: c5jMnVqbji8Ww_lit9ymiIulDc2msgXj
X-Authority-Analysis: v=2.4 cv=ar2CzyZV c=1 sm=1 tr=0 ts=6a10c8f2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ovJmrJClAAAA:8 a=qC_FGOx9AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=q7X4_axEi9qJq2Gpr8MA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=brTEhlvMp4NY0_u118I2:22 a=fsdK_YakeE02zTmptMdW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220212
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

VXBkYXRlIHRoZSBoZXhhZ29uIGNyb3NzLWNvbXBpbGVyIERvY2tlciBjb250YWluZXIgdG8gdXNl
IHRvb2xjaGFpbgp2ZXJzaW9uIDIyLjEuMCwgcmVwbGFjaW5nIHRoZSBwcmV2aW91cyAxMi5EZWMu
MjAyMyByZWxlYXNlLgoKQ2hhbmdlcyB0byBhY2NvbW1vZGF0ZSB0aGUgbmV3IHRvb2xjaGFpbjoK
Ci0gQWRkIGxpYmMrKzEsIGxpYmMrK2FiaTEsIGxpYnVud2luZC0xOSBydW50aW1lIGRlcHMgZm9y
IHRoZSBuZXcKICBMTFZNLWJhc2VkIHRvb2xjaGFpbgotIEFkZCB6c3RkIGZvciB0aGUgbmV3IC50
YXIuenN0IGFyY2hpdmUgZm9ybWF0Ci0gVXBkYXRlIGFydGlmYWN0IFVSTCBkb21haW4gdG8gYXJ0
aWZhY3RzLmNvZGVsaW5hcm8ub3JnCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGll
cnJpY2suYm91dmllckBsaW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL2Rl
Ymlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlciB8IDEwICsrKysrKystLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZG9j
a2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlciBiL3Rlc3RzL2RvY2tl
ci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIKaW5kZXggM2M5NGYwNDBi
ODEuLjIzZThiYjJmYjI2IDEwMDY0NAotLS0gYS90ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGVi
aWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyCisrKyBiL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9k
ZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIKQEAgLTE5LDcgKzE5LDExIEBAIFJVTiBhcHQtZ2V0
IHVwZGF0ZSAmJiBcCiAgICAgICAgIGN1cmwgXAogICAgICAgICBjY2FjaGUgXAogICAgICAgICB4
ei11dGlscyBcCisgICAgICAgIHpzdGQgXAogICAgICAgICBjYS1jZXJ0aWZpY2F0ZXMgXAorICAg
ICAgICBsaWJjKysxIFwKKyAgICAgICAgbGliYysrYWJpMSBcCisgICAgICAgIGxpYnVud2luZC0x
OSBcCiAgICAgICAgIGJpc29uIFwKICAgICAgICAgZmxleCBcCiAgICAgICAgIGdpdCBcCkBAIC00
MCwxMiArNDQsMTIgQEAgUlVOIGFwdC1nZXQgdXBkYXRlICYmIFwKICAgICBkcGtnLXF1ZXJ5IC0t
c2hvd2Zvcm1hdCAnJHtQYWNrYWdlfV8ke1ZlcnNpb259XyR7QXJjaGl0ZWN0dXJlfVxuJyAtLXNo
b3cgPiAvcGFja2FnZXMudHh0CiAKIEVOViBUT09MQ0hBSU5fSU5TVEFMTD0vb3B0Ci1FTlYgVE9P
TENIQUlOX1JFTEVBU0U9MTIuRGVjLjIwMjMKK0VOViBUT09MQ0hBSU5fUkVMRUFTRT0yMi4xLjAK
IEVOViBUT09MQ0hBSU5fQkFTRU5BTUU9Y2xhbmcrbGx2bS0ke1RPT0xDSEFJTl9SRUxFQVNFfS1j
cm9zcy1oZXhhZ29uLXVua25vd24tbGludXgtbXVzbAotRU5WIFRPT0xDSEFJTl9VUkw9aHR0cHM6
Ly9jb2RlbGluYXJvLmpmcm9nLmlvL2FydGlmYWN0b3J5L2NvZGVsaW5hcm8tdG9vbGNoYWluLWZv
ci1oZXhhZ29uLyR7VE9PTENIQUlOX1JFTEVBU0V9LyR7VE9PTENIQUlOX0JBU0VOQU1FfS50YXIu
eHoKK0VOViBUT09MQ0hBSU5fVVJMPWh0dHBzOi8vYXJ0aWZhY3RzLmNvZGVsaW5hcm8ub3JnL2Fy
dGlmYWN0b3J5L2NvZGVsaW5hcm8tdG9vbGNoYWluLWZvci1oZXhhZ29uLyR7VE9PTENIQUlOX1JF
TEVBU0V9Xy8ke1RPT0xDSEFJTl9CQVNFTkFNRX0udGFyLnpzdAogRU5WIENDQUNIRV9XUkFQUEVS
U0RJUj0vdXNyL2xpYmV4ZWMvY2NhY2hlLXdyYXBwZXJzCiAKLVJVTiBjdXJsIC0jU0wgIiRUT09M
Q0hBSU5fVVJMIiB8IHRhciAteEpDICIkVE9PTENIQUlOX0lOU1RBTEwiCitSVU4gY3VybCAtI1NM
ICIkVE9PTENIQUlOX1VSTCIgfCB0YXIgLS16c3RkIC14QyAiJFRPT0xDSEFJTl9JTlNUQUxMIgog
RU5WIFBBVEg9JFBBVEg6JHtUT09MQ0hBSU5fSU5TVEFMTH0vJHtUT09MQ0hBSU5fQkFTRU5BTUV9
L3g4Nl82NC1saW51eC1nbnUvYmluCiBFTlYgTUFLRT0vdXNyL2Jpbi9tYWtlCiAjIEFzIGEgZmlu
YWwgc3RlcCBjb25maWd1cmUgdGhlIHVzZXIgKGlmIGVudiBpcyBkZWZpbmVkKQotLSAKMi4zNC4x
Cgo=

