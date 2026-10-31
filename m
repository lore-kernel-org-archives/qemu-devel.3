Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50874606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=djpODokY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FHPCo/qA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxwg-0006fw-9B; Fri, 30 Oct 2026 21:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxwM-0005jc-QJ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxwK-00039Y-SH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:26 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1CHwW1314016
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XYBE0GBY1vQqA0EKvIESjgtZN4oxA2YVWeJmVKholOk=; b=djpODokYnMsaURSZ
 bCy4kuyJqSKP1RJqaBwuAiaXG0Sb2P8JfCD8GRV4JYDGe/j8kgn71nEdfWtOeCa1
 bR+SBav/dv1pblHFyfUn/SySQS+QEsCEK2xPf6TjHZdyBA4pSp3EOm1beYma2a2L
 r/NCKBFtueXEHO6LLVoVfw1go7U6BhjaLknOX0Xxw0Wfpq4+kvejVnaOFkUOHzCp
 Tcwv9lQEUz38hvYr+ewN61eAmem/KkSy7JOzgFXR17seu0hibWEgZjd5eb4j3SGt
 ysXaCT/QFQDqPI6lWeW1u215nTAC5QUMpJ3eKTTexG7D72gs8ZMgXEqjbdZStMnD
 kjNixg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x10qvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a3451ea93so2052082eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410273; x=1794015073; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XYBE0GBY1vQqA0EKvIESjgtZN4oxA2YVWeJmVKholOk=;
 b=FHPCo/qAd9N1pwxaaX5tmMVyHQt0xdDO14K5fvvTr7vzQz+PZf/ANgNIegsWvz59PL
 njSfFZiKe9Ejq7xOMVfbTsbWmMMcQsVphC+hPOMLQmS0HANc3Zd7h7vq9lw9Use1EZin
 3o7EML8AQ34ibSbCwhdz8h28TPPdXK/YYoGKstbd4utNV4X4h72HGjC8+pt/W0RpwdGn
 obifwOkS9sbbMbL73xKYVj268yjc9jfeWCjo4bSu2E53EB/V5CYY2M8SIdM+cfBvAnz6
 8MA9VrRCMG0Y0DdUfh3OLHrELVz+LUIFcG4UafNktBthwFV9p24s3Xr/NWIA86xu8Y7y
 JWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410273; x=1794015073;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XYBE0GBY1vQqA0EKvIESjgtZN4oxA2YVWeJmVKholOk=;
 b=bG3vU4m+8++XCarsuMRk39yRzNbbBfUCfoXWyxiRYG4xJHRykOw8WMcOt1HJ6JMpw5
 Wjop2pZj/Tc2C7K9ScuoB69hupb8cTgiJ+zIfqg2oDnyfOMLx2xQHiNkkaW0kgQk4Vq7
 i66akqwlkdDxVdMjwWwAB9CH/GJmnqjLSrlTnaMxc6+ImcyqABYHuiyFGppypqgWN4uJ
 /vmmVnuWGecHD3I9vQy3qHbBqDXiLhobzeLeut4pJCnuG/jyT1JYYjwTP+uQHE6K9uPx
 wX+yDNvHPgm04Z+UDYEcmJtHWDkPs4OKJGbbG/w0NCLMi3BPFfcqw0sXSwaL0elJ+/Nq
 2bew==
X-Gm-Message-State: AFq9FYJB+Ioq/eLAIgJCZrApuVzilUzoqHZQ3GCkgeTkeapKsHHXUhyJ
 ksO1jFXVlDjMg7Rde4s54CxM1kisQQSdig3fTV37ZJjKJxfnFNxQQMziyT8DnmUV6cGGmSkapKj
 GIXIaOkknZp9ymcmwKn51UkQiMjK8Om+7Ymd249g15I8HhGOcpzSXBUKZuPgHP5MoZQ==
X-Gm-Gg: AYBFou2WqFfVKxFzas4tT21Vs3JfI7clx1CSNBahMoFonTMe6ef+P9q3zg7lOjTGZML
 DAcjmzOUD1q4E0Wl9DKYsJ/r8rp2LINwss2EqxKd+ascY9UBk9qVKz2YoSdVO+fLog1tmpL+j8a
 Ur+J3NMc8qp8hb+rCLMXtMjGwhsazIo4pDOf2UgRJDpPHnhgT88dnn7kDCg4cGjoaNjChl/ali+
 0d9r/8L2IaQgUzQWeXcuOYYFx3n5cE8uF583LErrek6NY1tXKXq1D1MK6YoRcEZZccRFxemcgfF
 r8mYFUBdgarVE+xtbTqw1+apXVRTg2NlnnPAUkNO+jE5HPLz/RUTLYp3kd1q9P5nHc7hxhgY1uI
 NLxrVpT/aZjyzvOCxs63HSrFkO+pvh7PEa/GlM691HwmB9cEll4XnlHlQSDKLSBDvc8CJZhuaDR
 rGmYf7sHeuGQw+lPrErwnfsw==
X-Received: by 2002:a05:693c:4095:b0:351:4d2d:af26 with SMTP id
 5a478bee46e88-36a4220016fmr6869001eec.2.1793410272748; 
 Fri, 30 Oct 2026 18:31:12 -0700 (PDT)
X-Received: by 2002:a05:693c:4095:b0:351:4d2d:af26 with SMTP id
 5a478bee46e88-36a4220016fmr6868952eec.2.1793410271952; 
 Fri, 30 Oct 2026 18:31:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:31:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 39/40] hw/hexagon: migrate the HMX state
Date: Fri, 30 Oct 2026 18:29:40 -0700
Message-Id: <20261031012941.339141-40-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX5mqysbUhYcU4
 PeNZF8Xttpj9TmAphDEri77rsokKtIHIdZKbaWLZnqAiD90FEZNIwHC3ueitXkV+A5qfT0zdcYY
 sxdy0ZfD77YD4AtFxYLTlI4xfpsRCdr+V42mwbo4rZI43bARaJ66EsZ51n2ONFGj9wAZI71kN7Z
 jEgwu+FmeWH/3uFzPDbAsNDUwG5VNXoIwEDe2IEItzImX5kyY68rPsII3izONHjNvrS4EZplTlm
 JtOf/G85YQTvVnalt11zJLNCyKZlAFeVO5klN5Lb+OZF8W2Ot51xN5JtlLRTmD7Z4VxsbiwiZRw
 8aGS3at/INbfa/NNk9RjE5tSwuxGTb/ZCLwR9nPsiximntOko2WAZYOQoJbD7WTC+3l7OFbao3a
 qJtSCNXQvDyLJ4Vmkji+o0N815POnhh/ZkfPgA11zVVCscGhbQnEdefea8vub6CQ+S9jN7Lk892
 /UFuqrpUagLmrWKeHDA==
X-Authority-Analysis: v=2.4 cv=CLG/zhrD c=1 sm=1 tr=0 ts=6ae544e1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=xdyA_gckl7Q-J04J5HIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX4VWxxWjVh00k
 L4h9e4CfhVrjkvtnOmd6+yoXvs/42iHxdSLtN1OvJsnsBCLgOIDlpgue/7AnZVqKPDahyk3xXYy
 2bX+hX5OIpTbwRo6nbm/yuQ/Rh9nfh4=
X-Proofpoint-GUID: ISjgEimFiMZKzPZ1GwB5h4hWEgU-zsgz
X-Proofpoint-ORIG-GUID: ISjgEimFiMZKzPZ1GwB5h4hWEgU-zsgz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310005
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiBody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuYyB8IDExNyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTE3IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleGFnb25faG14X2NvbnRleHQuYyBiL2h3L2hleGFnb24v
aGV4YWdvbl9obXhfY29udGV4dC5jCmluZGV4IGUzZWE3YjcxNDc0Li4zNjgzYmQ5ZDQxNiAxMDA2
NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmMKKysrIGIvaHcvaGV4YWdv
bi9oZXhhZ29uX2hteF9jb250ZXh0LmMKQEAgLTcsNiArNyw3IEBACiAKICNpbmNsdWRlICJxZW11
L29zZGVwLmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29uX2hteF9jb250ZXh0LmgiCisj
aW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCIKIAogc3RhdGljIHZvaWQgaGV4YWdvbl9obXhf
Y29udGV4dF9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKIHsKQEAgLTE1
LDYgKzE2LDEyMSBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2hteF9jb250ZXh0X3Jlc2V0X2hvbGQo
T2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogICAgIG1lbXNldCgmcy0+cmVncywgMCwgc2l6
ZW9mKHMtPnJlZ3MpKTsKIH0KIAorc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0
YXRlX2hteF9hY2NfZnhwID0geworICAgIC5uYW1lID0gImhleGFnb25faG14X2FjY19meHAiLAor
ICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWluaW11bV92ZXJzaW9uX2lkID0gMSwKKyAgICAu
ZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7CisgICAgICAgIFZNU1RBVEVfMkRBUlJB
WShkYXRhLCBIbXhBY2NGeHAsIEhNWF9TUEFUSUFMX0RJTV9GWFAsCisgICAgICAgICAgICAgICAg
ICAgICAgICBITVhfT1VUUFVUX0NIQU5ORUxTLCAwLCB2bXN0YXRlX2luZm9faW50MzIsIGludDMy
X3QpLAorICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkKKyAgICB9LAorfTsKKworc3RhdGlj
IGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX2hteF9hY2NfZnAgPSB7CisgICAgLm5h
bWUgPSAiaGV4YWdvbl9obXhfYWNjX2ZwIiwKKyAgICAudmVyc2lvbl9pZCA9IDEsCisgICAgLm1p
bmltdW1fdmVyc2lvbl9pZCA9IDEsCisgICAgLmZpZWxkcyA9IChjb25zdCBWTVN0YXRlRmllbGRb
XSkgeworICAgICAgICBWTVNUQVRFX1VJTlQ2NF8yREFSUkFZKGRhdGEsIEhteEFjY0ZwLCBITVhf
U1BBVElBTF9ESU1fRlAsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSE1YX09VVFBV
VF9DSEFOTkVMUyksCisgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQorICAgIH0sCit9Owor
CitzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaG14X2FjY19zZXQgPSB7
CisgICAgLm5hbWUgPSAiaGV4YWdvbl9obXhfYWNjX3NldCIsCisgICAgLnZlcnNpb25faWQgPSAx
LAorICAgIC5taW5pbXVtX3ZlcnNpb25faWQgPSAxLAorICAgIC5maWVsZHMgPSAoY29uc3QgVk1T
dGF0ZUZpZWxkW10pIHsKKyAgICAgICAgVk1TVEFURV9TVFJVQ1QoZnhwX3ByaW1hcnksIEhteEFj
Y1NldCwgMCwgdm1zdGF0ZV9obXhfYWNjX2Z4cCwKKyAgICAgICAgICAgICAgICAgICAgICAgSG14
QWNjRnhwKSwKKyAgICAgICAgVk1TVEFURV9TVFJVQ1QoZnBfcHJpbWFyeSwgSG14QWNjU2V0LCAw
LCB2bXN0YXRlX2hteF9hY2NfZnAsCisgICAgICAgICAgICAgICAgICAgICAgIEhteEFjY0ZwKSwK
KyAgICAgICAgVk1TVEFURV9FTkRfT0ZfTElTVCgpCisgICAgfSwKK307CisKK3N0YXRpYyBjb25z
dCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9obXhfY3Z0X2Z4cCA9IHsKKyAgICAubmFtZSA9
ICJoZXhhZ29uX2hteF9jdnRfZnhwIiwKKyAgICAudmVyc2lvbl9pZCA9IDEsCisgICAgLm1pbmlt
dW1fdmVyc2lvbl9pZCA9IDEsCisgICAgLmZpZWxkcyA9IChjb25zdCBWTVN0YXRlRmllbGRbXSkg
eworICAgICAgICBWTVNUQVRFX1VJTlQxNl8yREFSUkFZKGRhdGEsIEhteEN2dFN0YXRlRnhwLCBI
TVhfU1BBVElBTF9ESU1fRlhQLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhNWF9P
VVRQVVRfQ0hBTk5FTFMpLAorICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkKKyAgICB9LAor
fTsKKworc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX2hteF9jdnRfZnAg
PSB7CisgICAgLm5hbWUgPSAiaGV4YWdvbl9obXhfY3Z0X2ZwIiwKKyAgICAudmVyc2lvbl9pZCA9
IDEsCisgICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDEsCisgICAgLmZpZWxkcyA9IChjb25zdCBW
TVN0YXRlRmllbGRbXSkgeworICAgICAgICBWTVNUQVRFX1VJTlQxNl8yREFSUkFZKGRhdGEsIEht
eEN2dFN0YXRlRnAsIEhNWF9TUEFUSUFMX0RJTV9GUCwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBITVhfT1VUUFVUX0NIQU5ORUxTKSwKKyAgICAgICAgVk1TVEFURV9FTkRfT0ZfTElT
VCgpCisgICAgfSwKK307CisKK3N0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0
ZV9obXhfcmVncyA9IHsKKyAgICAubmFtZSA9ICJoZXhhZ29uX2hteF9yZWdzIiwKKyAgICAudmVy
c2lvbl9pZCA9IDEsCisgICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDEsCisgICAgLmZpZWxkcyA9
IChjb25zdCBWTVN0YXRlRmllbGRbXSkgeworICAgICAgICBWTVNUQVRFX1NUUlVDVF9BUlJBWShh
Y2MsIEhteFN0YXRlLCBITVhfTlVNX0FDQ19TRVRTLCAwLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2bXN0YXRlX2hteF9hY2Nfc2V0LCBIbXhBY2NTZXQpLAorICAgICAgICBWTVNUQVRF
X1NUUlVDVF9BUlJBWShjdnRfZnhwLCBIbXhTdGF0ZSwgSE1YX05VTV9DVlRfQUdFUywgMCwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdm1zdGF0ZV9obXhfY3Z0X2Z4cCwgSG14Q3Z0U3Rh
dGVGeHApLAorICAgICAgICBWTVNUQVRFX1NUUlVDVF9BUlJBWShjdnRfZnAsIEhteFN0YXRlLCBI
TVhfTlVNX0NWVF9BR0VTLCAwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2bXN0YXRl
X2hteF9jdnRfZnAsIEhteEN2dFN0YXRlRnApLAorICAgICAgICBWTVNUQVRFX1NUUlVDVChjdnRf
ZnV0dXJlX2Z4cCwgSG14U3RhdGUsIDAsIHZtc3RhdGVfaG14X2N2dF9meHAsCisgICAgICAgICAg
ICAgICAgICAgICAgIEhteEN2dFN0YXRlRnhwKSwKKyAgICAgICAgVk1TVEFURV9VSU5UNjRfMkRB
UlJBWShiaWFzX3JhdywgSG14U3RhdGUsIEhNWF9OVU1fQklBU19TRVRTLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEhNWF9PVVRQVVRfQ0hBTk5FTFMpLAorICAgICAgICBWTVNUQVRF
X1VJTlQzMihjdXJyZW50X2FjY19zZXQsIEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFURV9CVUZG
RVIoYWN0X2J1ZmZlciwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihhY3RfcnMs
IEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoYWN0X3R5cGUsIEhteFN0YXRlKSwK
KyAgICAgICAgVk1TVEFURV9VSU5UOChpc19mOF9vZGQsIEhteFN0YXRlKSwKKyAgICAgICAgVk1T
VEFURV9VSU5UOChmcDhfb2RkX3NlbCwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
Mihmb3JtYXRfb2Zmc2V0LCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKHRpbGVf
eF9tYXNrLCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKHRpbGVfeV9tYXNrLCBI
bXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKHRpbGVfeF9pbmMsIEhteFN0YXRlKSwK
KyAgICAgICAgVk1TVEFURV9VSU5UMzIodGlsZV95X2luYywgSG14U3RhdGUpLAorICAgICAgICBW
TVNUQVRFX1VJTlQzMihmeCwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihmeSwg
SG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX0lOVDMyKGNoX3N0YXJ0LCBIbXhTdGF0ZSksCisg
ICAgICAgIFZNU1RBVEVfSU5UMzIoY2hfc3RvcCwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRF
X1VJTlQzMih5X3N0YXJ0LCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKHlfc3Rv
cCwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMih5X2RpbGF0ZSwgSG14U3RhdGUp
LAorICAgICAgICBWTVNUQVRFX1VJTlQzMihibG9ja3MsIEhteFN0YXRlKSwKKyAgICAgICAgVk1T
VEFURV9JTlQzMihkWSwgSG14U3RhdGUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihncm91cF9j
b252LCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGdyb3VwX3NpemUsIEhteFN0
YXRlKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZ3JvdXBfY291bnQsIEhteFN0YXRlKSwKKyAg
ICAgICAgVk1TVEFURV9JTlQzMihtYWNfY3ljbGVfbGltaXQsIEhteFN0YXRlKSwKKyAgICAgICAg
Vk1TVEFURV9VSU5UMzIoY3Z0X2Z4cF9wZW5kaW5nLCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RB
VEVfVUlOVDMyKGN2dF9meHBfcGVuZGluZ19hZ2UsIEhteFN0YXRlKSwKKyAgICAgICAgVk1TVEFU
RV9VSU5UMzIoY3Z0X2FjY19jbGVhcl9wZW5kaW5nLCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RB
VEVfVUlOVDMyKGN2dF9hY2NfY2xlYXJfc2V0LCBIbXhTdGF0ZSksCisgICAgICAgIFZNU1RBVEVf
RU5EX09GX0xJU1QoKQorICAgIH0sCit9OworCitzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0
aW9uIHZtc3RhdGVfaGV4YWdvbl9obXhfY29udGV4dCA9IHsKKyAgICAubmFtZSA9ICJoZXhhZ29u
X2hteF9jb250ZXh0IiwKKyAgICAudmVyc2lvbl9pZCA9IDEsCisgICAgLm1pbmltdW1fdmVyc2lv
bl9pZCA9IDEsCisgICAgLmZpZWxkcyA9IChjb25zdCBWTVN0YXRlRmllbGRbXSkgeworICAgICAg
ICBWTVNUQVRFX1NUUlVDVChyZWdzLCBIZXhhZ29uSE1YQ29udGV4dFN0YXRlLCAxLCB2bXN0YXRl
X2hteF9yZWdzLAorICAgICAgICAgICAgICAgICAgICAgICBIbXhTdGF0ZSksCisgICAgICAgIFZN
U1RBVEVfRU5EX09GX0xJU1QoKQorICAgIH0sCit9OworCiBzdGF0aWMgdm9pZCBoZXhhZ29uX2ht
eF9jb250ZXh0X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHZvaWQgKmRhdGEpCiB7CkBAIC0yMiw2
ICsxMzgsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2hteF9jb250ZXh0X2NsYXNzX2luaXQoT2Jq
ZWN0Q2xhc3MgKmtsYXNzLAogICAgIFJlc2V0dGFibGVDbGFzcyAqcmMgPSBSRVNFVFRBQkxFX0NM
QVNTKGtsYXNzKTsKIAogICAgIHJjLT5waGFzZXMuaG9sZCA9IGhleGFnb25faG14X2NvbnRleHRf
cmVzZXRfaG9sZDsKKyAgICBkYy0+dm1zZCA9ICZ2bXN0YXRlX2hleGFnb25faG14X2NvbnRleHQ7
CiAgICAgZGMtPnVzZXJfY3JlYXRhYmxlID0gZmFsc2U7CiB9CiAKLS0gCjIuMzQuMQoK

