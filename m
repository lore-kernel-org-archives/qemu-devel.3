Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A2606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a4q1LE3H;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PVdL+kva
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMcYm-00044u-Vi; Thu, 29 Oct 2026 22:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYQ-00043D-Fh
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYO-0005sL-DK
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U2K0GP2534842
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ap/eiC6BAtCEQ58cjHVOwTFZankQmoNBpnTZ2yMeOIs=; b=a4q1LE3H9CSI6UIv
 CEqP4s6SEUhYjaA/gb9YK5bEivzSgp2iq5IfFkJgTcFJgUDfEP7ywCc4GrVMv22A
 53OnwvIrmsc1NbizollG7d9Yv+ZlORL1S/BpINCfo6KvTojlmkg3N+Y1sobGJ8HH
 Gm6iKUXa7FEyeH5db6SKa3zrUHs/kzHMqJ9dQXLWFhEJO/kIfKAsiM13V8VBhxz2
 7hIwplgMIZw5V8JfvMdfD1CsMQ340qcDEp2/RFE+louEHRcroxcosvgF2zlfZZUv
 6jwmIctezbJ8i7RST9cwFpb5Sx/E+JG8LnFdf5UYH8iBpTRSzvOmNizmwhRNcGkR
 AUd0bA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qruev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so404288eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793328074; x=1793932874; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ap/eiC6BAtCEQ58cjHVOwTFZankQmoNBpnTZ2yMeOIs=;
 b=PVdL+kvaVYEGVXzDBSTuEMTnfOyUVrLHomuLud8jtJFOumub8Guew1PmqvkT1FA4lv
 Fjo5tZ7+j9I4Bt3ALpAPpg9rAva/Oq2OKT1lCDMIQuTXIz8Ncv00kS3WvSvx9esWEJ5m
 eGFhHeaNwVjJiy1NMhrKidAEBMwKdVpSkEEFjqzAucuKxlFWnzqSa+upVSaIaWwdHVHK
 8HuBc7Z7gZMGPJbVVlPjHrDnH4ajtBpcw6dpKKEcFewSRbtG8bXY8bbHL8WAaVOZv1cJ
 X2vrFBMt+MQVEecOjFS4UMwzwaodrCyj8+ZWnWAvijRG5oYFwrjfDfEyje1iGU2Vzttm
 PHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793328074; x=1793932874;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ap/eiC6BAtCEQ58cjHVOwTFZankQmoNBpnTZ2yMeOIs=;
 b=gLHy6T3/AmI13SE9KkJBcCxHX5OhLjHpBw44Rc+frX62SQpD/u+1cNfnuz5uxmhRl0
 0PXaYIeMVctLnT7LWxhd9omra7KJ2585VUCX3AzejHbwqaqviPF2wGK7LWyFtTcRO4bU
 e44SCp04gE+Jh2Qug4AhJiGCG2M4U19ptGBSBg3chLRnOi3tUOlzaba7wqn2VxPPxJYi
 2/x58ppft2EVnREj6embsaOMFaP7aTN/D86lB4hTqzM4EZBNTGHBjiIWPTjrMkd1hlOk
 LjbpnZMmHE8xehIbgUSGxdSmfHl8Sn+Q/Q4LlWeLTWEqlb5gpYw2LBvWeZE2G1oWmWUi
 IXOg==
X-Gm-Message-State: AFq9FYIzy6mhYT21gp2sVljugkD5KE2VVS8oMk/DehtwJ6R56icZKcCZ
 LLuo9tch4fYbGSggQ2AvZi56pW2Gv+AH4frtfENxj6TsQKi9mZ5a0xc4pob1d/hpY3GG627YEZA
 1QGqNS7Q197U20gAuXjX2mmCMy5c63F0Gnw0dzLM7mZcX3Yq4FH5kHf5L1KVZhIOt/Q==
X-Gm-Gg: AYBFou1nYAu7nDiIaXtvydSh3Pf7lKP+z5JDB7z+nbuztIzxI5flit4zj/hR19XnQRg
 SqcpxH6wo9nT+MTmPFmtQazATfZoBs09RJwrCZwfr1/7SOPGAxbrGZmhHRwPhnOxKoxOd/FSWu7
 olOAQ+Qj9vAuLUmMk25fRHyAxj/7w6UhmJ0k8pE/809ICQiw4n6lO2IhoNipsyKGXXjLiPypzjS
 7IClLZmQ9BexftgjYDulh0WRBeQ/0rP2FzG5ndsnMzQHAeEwQNEuA4gRnV7/kTxc8UnO/qIEx/b
 vksbUR4xlaZj2e7+a3Ac+B8rBldT4IxCevCHiwOvGeAmIH59K7oAQc/OuSAg5BnuPaCEJbUebbz
 KdbIAOog9bERZgenSOgkAC/VRRuYBQ/adEJOzVBfCCZzPMrd75J4/oTwzVIBRv11pkvVLwYhaEU
 SCb7l7LnMjSKVXeV/rpXN7mQ==
X-Received: by 2002:a05:693c:42cb:b0:35d:95e4:267d with SMTP id
 5a478bee46e88-36a424027b6mr1503278eec.27.1793328073404; 
 Thu, 29 Oct 2026 19:41:13 -0700 (PDT)
X-Received: by 2002:a05:693c:42cb:b0:35d:95e4:267d with SMTP id
 5a478bee46e88-36a424027b6mr1503238eec.27.1793328072556; 
 Thu, 29 Oct 2026 19:41:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4294419dsm2704624eec.18.2026.10.29.19.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 19:41:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 1/8] target/hexagon: add HMX attrs, state
Date: Thu, 29 Oct 2026 19:41:03 -0700
Message-Id: <20261030024110.1986536-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
References: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: T7Yw8axqbdrYeg1X1GRdRPwPC6_8X0NJ
X-Proofpoint-ORIG-GUID: T7Yw8axqbdrYeg1X1GRdRPwPC6_8X0NJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfX/x9Cx1iLiIc9
 vvYdAjcVIzZj+pEcYjgePwJ/OWfWkDX9eD9cKjvK+sCjUD631shKrmxFouGqlwm4iyuVRCNBJAP
 iBEUrCgXJ1zpVbwJ1XmEbLOoLTvpfKLoNJ1v3sOjJ8TW7rtVDLBrn21XRMXh7UfBZeUQPxcOYBC
 7NqZ25TSILW42zJXLMT2IRdVHC07d/JthBAQ1AKBdnqdbSh6LuhbRaismUZTRhW23ugHj+t0C7V
 /RG+KCA/IxO0PwJltOnATnZMgLwuEOaGgSvAXs/ZNH95MaUaSiEMKg34hn2YVDiLp4nNGLVAcxC
 R6x/zauMXuor2IKV9IAD7/lRlT49+2OLPqqTcwjkUpF/49DwHmHOuF/ZX/XJw9vqUXg2YAlrxgV
 T5St6HGSdYzyzoVr/fkBcYE6CoZncvh7fkcqVdE8lBcD8iF2ca+3I7/13N/xC7t8Fi2UubwtstJ
 EV8QZe0fNwQ3YJDOMFw==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae403ca cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=eIqSBVWmwaVrM3dqyzoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfX02rIRxsaHVqf
 QLQ9Xtspc4pF10jHurGAEp1cBtKZ8k6Yr5OJ7fnCMeSIvklAkSV5rpuNQNqWcjJKzMDZTOJuTUD
 bu0Hse8cjZH6G41qeop5ay0+N27Y90s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300010
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

QWRkIGluc3QgYXR0cmlidXRlcyBmb3IgSE1YIGFuZCBzdGF0ZSBkZWZpbml0aW9uLgoKUmV2aWV3
ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9obXhfc3RhdGUuaCAgICAgICB8IDkyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYyB8IDEzICsrKysr
CiAyIGZpbGVzIGNoYW5nZWQsIDEwNSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGFyZ2V0L2hleGFnb24vaG14X3N0YXRlLmgKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9o
bXhfc3RhdGUuaCBiL3RhcmdldC9oZXhhZ29uL2hteF9zdGF0ZS5oCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwLi40M2M4Y2JkOWUwNwotLS0gL2Rldi9udWxsCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2hteF9zdGF0ZS5oCkBAIC0wLDAgKzEsOTIgQEAKKy8qCisgKiBIZXhhZ29u
IEhNWCAoTWF0cml4IGVYdGVuc2lvbnMpIFN0YXRlIERlZmluaXRpb25zCisgKgorICogQ29weXJp
Z2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJp
ZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisK
KyNpZm5kZWYgSEVYQUdPTl9ITVhfU1RBVEVfSAorI2RlZmluZSBIRVhBR09OX0hNWF9TVEFURV9I
CisKKyNkZWZpbmUgSE1YX1NQQVRJQUxfRElNX0ZYUCAgICAgNjQKKyNkZWZpbmUgSE1YX1NQQVRJ
QUxfRElNX0ZQICAgICAgMzIKKyNkZWZpbmUgSE1YX09VVFBVVF9DSEFOTkVMUyAgICAgMzIKKyNk
ZWZpbmUgSE1YX05VTV9BQ0NfU0VUUyAgICAgICAgMgorI2RlZmluZSBITVhfTlVNX0NWVF9BR0VT
ICAgICAgICAzCisjZGVmaW5lIEhNWF9OVU1fQklBU19TRVRTICAgICAgIDQKKworI2RlZmluZSBI
TVhfQUNUX0NST1VUT05fU0laRSAgICAyMDQ4CisjZGVmaW5lIEhNWF9BQ1RfQ0FDSEVfU0laRSAg
ICAgICgyICogSE1YX0FDVF9DUk9VVE9OX1NJWkUpCisKK3R5cGVkZWYgc3RydWN0IEhteEFjY0Z4
cCB7CisgICAgaW50MzJfdCBkYXRhW0hNWF9TUEFUSUFMX0RJTV9GWFBdW0hNWF9PVVRQVVRfQ0hB
Tk5FTFNdOworfSBIbXhBY2NGeHA7CisKKy8qIEZQIGFjY3VtdWxhdG9yIGNlbGwgc3RvcmFnZTog
SUVFRSBiaW5hcnk2NCBiaXQgcGF0dGVybnMgKi8KK3R5cGVkZWYgc3RydWN0IEhteEFjY0ZwIHsK
KyAgICB1aW50NjRfdCBkYXRhW0hNWF9TUEFUSUFMX0RJTV9GUF1bSE1YX09VVFBVVF9DSEFOTkVM
U107Cit9IEhteEFjY0ZwOworCit0eXBlZGVmIHN0cnVjdCBIbXhBY2NTZXQgeworICAgIEhteEFj
Y0Z4cCBmeHBfcHJpbWFyeTsKKyAgICBIbXhBY2NGcCAgZnBfcHJpbWFyeTsKK30gSG14QWNjU2V0
OworCit0eXBlZGVmIHN0cnVjdCBIbXhDdnRTdGF0ZUZ4cCB7CisgICAgdWludDE2X3QgZGF0YVtI
TVhfU1BBVElBTF9ESU1fRlhQXVtITVhfT1VUUFVUX0NIQU5ORUxTXTsKK30gSG14Q3Z0U3RhdGVG
eHA7CisKKy8qIEZQIGNvbnZlcnQgc2xvdDogb25lIEZQMTYgdmFsdWUsIG9yIGFuIEZQOCBieXRl
IHBlciBzcGF0aWFsIGhhbGYgKi8KK3R5cGVkZWYgc3RydWN0IEhteEN2dFN0YXRlRnAgeworICAg
IHVpbnQxNl90IGRhdGFbSE1YX1NQQVRJQUxfRElNX0ZQXVtITVhfT1VUUFVUX0NIQU5ORUxTXTsK
K30gSG14Q3Z0U3RhdGVGcDsKKwordHlwZWRlZiBzdHJ1Y3QgSG14U3RhdGUgeworICAgIEhteEFj
Y1NldCBhY2NbSE1YX05VTV9BQ0NfU0VUU107CisKKyAgICBIbXhDdnRTdGF0ZUZ4cCBjdnRfZnhw
W0hNWF9OVU1fQ1ZUX0FHRVNdOworICAgIEhteEN2dFN0YXRlRnAgIGN2dF9mcFtITVhfTlVNX0NW
VF9BR0VTXTsKKworICAgIEhteEN2dFN0YXRlRnhwIGN2dF9mdXR1cmVfZnhwOworCisgICAgdWlu
dDY0X3QgYmlhc19yYXdbSE1YX05VTV9CSUFTX1NFVFNdW0hNWF9PVVRQVVRfQ0hBTk5FTFNdOwor
CisgICAgdWludDMyX3QgY3VycmVudF9hY2Nfc2V0OworCisgICAgdWludDhfdCBhY3RfYnVmZmVy
W0hNWF9BQ1RfQ0FDSEVfU0laRV07CisKKyAgICB1aW50MzJfdCBhY3RfcnM7CisgICAgdWludDMy
X3QgYWN0X3R5cGU7CisgICAgdWludDhfdCAgaXNfZjhfb2RkOyAgICAgLyogUnNbMF06IEZQOCBh
Y3RpdmF0aW9uIHJlYWRzIG9kZCBieXRlIG9mIHBhaXIgKi8KKyAgICB1aW50OF90ICBmcDhfb2Rk
X3NlbDsgICAvKiBjdnQgUnNbMTFdOiBGUDggY29udmVydCB3cml0ZXMgb2RkICgxKSBoYWxmICov
CisKKyAgICB1aW50MzJfdCBmb3JtYXRfb2Zmc2V0OyAgICAgLyogU009MiwgRE09MCAqLworICAg
IHVpbnQzMl90IHRpbGVfeF9tYXNrOworICAgIHVpbnQzMl90IHRpbGVfeV9tYXNrOworICAgIHVp
bnQzMl90IHRpbGVfeF9pbmM7CisgICAgdWludDMyX3QgdGlsZV95X2luYzsKKyAgICB1aW50MzJf
dCBmeDsKKyAgICB1aW50MzJfdCBmeTsKKyAgICBpbnQzMl90ICBjaF9zdGFydDsgICAgICAgICAg
LyogcHJlLWNvbXB1dGVkIGNoYW5uZWwgc3RhcnQgKHJhdykgKi8KKyAgICBpbnQzMl90ICBjaF9z
dG9wOyAgICAgICAgICAgLyogcHJlLWNvbXB1dGVkIGNoYW5uZWwgc3RvcCAoZXhjbHVzaXZlKSAq
LworICAgIHVpbnQzMl90IHlfc3RhcnQ7CisgICAgdWludDMyX3QgeV9zdG9wOworICAgIHVpbnQz
Ml90IHlfZGlsYXRlOworICAgIHVpbnQzMl90IGJsb2NrczsKKyAgICBpbnQzMl90ICBkWTsgICAg
ICAgICAgICAgICAgLyogb2Zmc2V0IHRvIHNlY29uZCBhY3RpdmF0aW9uIGNyb3V0b24gKi8KKyAg
ICB1aW50MzJfdCBncm91cF9jb252OyAgICAgICAgLyogY2hfc3RhcnQgPiBjaF9zdG9wICovCisg
ICAgdWludDMyX3QgZ3JvdXBfc2l6ZTsKKyAgICB1aW50MzJfdCBncm91cF9jb3VudDsKKworICAg
IGludDMyX3QgIG1hY19jeWNsZV9saW1pdDsKKworICAgIC8qIERlZmVycmVkIENWVCBwaXBlbGlu
ZSBjb21taXQsIGF0IHRoZSBuZXh0IGNvbnN1bWVyIG9yIGVuZCBvZiBwYWNrZXQgKi8KKyAgICB1
aW50MzJfdCBjdnRfZnhwX3BlbmRpbmc7ICAgICAgLyogMSA9IGZ1dHVyZSBoYXMgdW5jb21taXR0
ZWQgZGF0YSAqLworICAgIHVpbnQzMl90IGN2dF9meHBfcGVuZGluZ19hZ2U7ICAvKiAxID0gcGlw
ZWxpbmUgc2hvdWxkIGFnZSBhdCBjb21taXQgKi8KKworICAgIC8qIERlZmVycmVkIGFjY3VtdWxh
dG9yIGNsZWFyL2ZsaXAsIGF0IHBhY2tldCBlbmQgb3IgbmV4dCBhY2N1bXVsYXRvciB1c2UgKi8K
KyAgICB1aW50MzJfdCBjdnRfYWNjX2NsZWFyX3BlbmRpbmc7CisgICAgdWludDMyX3QgY3Z0X2Fj
Y19jbGVhcl9zZXQ7Cit9IEhteFN0YXRlOworCisjZW5kaWYgLyogSEVYQUdPTl9ITVhfU1RBVEVf
SCAqLwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMgYi90YXJn
ZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYwppbmRleCA5NmFkMWZkMmY4ZS4uNDM5YTI2OGI1
OTEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCkBAIC0yMTAsNSArMjEwLDE4IEBAIERFRl9B
VFRSSUIoSFZYX0lFRUVfRlBfT1VUXzMyLCAiSFZYIElFRUUgRlAgMzItYml0IG91dHB1dCIsICIi
LCAiIikKIERFRl9BVFRSSUIoQ1ZJX1ZYX05PX1RNUF9MRCwgIkhWWCBtdWx0aXBseSB3aXRob3V0
IHRtcCBsb2FkIiwgIiIsICIiKQogREVGX0FUVFJJQihIVlhfRkxULCAiVGhpcyBhIGZsb2F0aW5n
IHBvaW50IEhWWCBpbnN0cnVjdGlvbi4iLCAiIiwgIiIpCiAKK0RFRl9BVFRSSUIoU0hBUkVEX0VY
VEVOU0lPTiwgIlNoYXJlZCBleHRlbnNpb24gaW5zdHJ1Y3Rpb24iLCAiIiwgIiIpCitERUZfQVRU
UklCKEVBX1JFR19PTkxZLCAiRUEgPSBpbnB1dCByZWdpc3RlciBvbmx5IiwgIiIsICIiKQorREVG
X0FUVFJJQihFQV9QQUdFQ1JPU1MsICJFQSBjYWxjdWxhdGlvbiBjYW4gaGF2ZSBhIFBhZ2UgQ3Jv
c3MgU3RhbGwiLCAiIiwgIiIpCitERUZfQVRUUklCKE1QWSwgIkhhcyBhIG11bHRpcGx5IiwgIiIs
ICIiKQorREVGX0FUVFJJQihQQUlSXzFPRjIsICJGb3IgYXNzZW1ibGVyIiwgIiIsICIiKQorREVG
X0FUVFJJQihQQUlSXzJPRjIsICJGb3IgYXNzZW1ibGVyIiwgIiIsICIiKQorREVGX0FUVFJJQihI
TVgsICJITVggY29wcm9jZXNzb3IgaW5zdHJ1Y3Rpb24iLCAiIiwgIiIpCitERUZfQVRUUklCKEhN
WF9DVlQsICJITVggY29udmVydCBpbnN0cnVjdGlvbiIsICIiLCAiIikKK0RFRl9BVFRSSUIoSE1Y
X0ZMVCwgIkhNWCBmbG9hdGluZy1wb2ludCBpbnN0cnVjdGlvbiIsICIiLCAiIikKK0RFRl9BVFRS
SUIoSE1YX0NVX1NDQUxBUiwgIkhNWCBzY2FsYXIgb3BlcmFuZCIsICIiLCAiIikKK0RFRl9BVFRS
SUIoSE1YX0JMT0NLX0FMSUdOLCAiSE1YIGJsb2NrLWFsaWduZWQgYWNjZXNzIiwgIiIsICIiKQor
REVGX0FUVFJJQihITVhfMTI4Ql9BTElHTiwgIkhNWCAxMjgtYnl0ZSBhbGlnbmVkIGFjY2VzcyIs
ICIiLCAiIikKKwogLyogS2VlcCB0aGlzIGFzIHRoZSBsYXN0IGF0dHJpYnV0ZTogKi8KIERFRl9B
VFRSSUIoWlpfTEFTVEFUVFJJQiwgIkxhc3QgYXR0cmlidXRlIGluIHRoZSBmaWxlIiwgIiIsICIi
KQotLSAKMi4zNC4xCgo=

