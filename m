Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A1EC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB76-0004pj-Iy; Wed, 12 Aug 2026 11:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6x-0004gL-Ly
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB6w-0000LO-3P
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbpiO3875499
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c02fVbhAOudqyZ1yr7+yFyrl17CR8xGkMKQ8YOwRWdU=; b=JFPGjDW0YVgasHJq
 Ax9Dec1PeEuSazEZ4UyxZh83KFFDKi0N+aDu9F3ctXsi/i0bz1gro/QtuxWf3iRQ
 OekXGp+WeMv0Lrz1zB8CHcFgy8L0kIKh9l+YWGkI5Bk2OiCd16SGHrBSX/4eKOO8
 ipqDwP2I183ES0zFOE1sV4ywHX5p3mabujDvFg454H2FZKOwa3tzSu7wDLCNNu/d
 oy2KtNEpYlMmyMyonBwb2cTjnskOjbLLcohYjfNYrQcKfskiwKF3Yeo0Yjdfcp2g
 oF1ygoTtdGbpjCCThDnYQC5eawnA3UQvskAFtmi4ZgSP16pdLogit1f1AJsui3WO
 ETigZA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1jst1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbeeaabcadfso547903a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549390; x=1787154190; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c02fVbhAOudqyZ1yr7+yFyrl17CR8xGkMKQ8YOwRWdU=;
 b=RUlwtGY2VN3/xM57Cc0X4zxcL6sA1lBwRdA68buobsqTMKXah1pQWAQQkwAlaskc2e
 FDwyABaabZx9IzF1Q9sutd7quPWduChBkRLkwp72Zx8MrXgqab+RbVW84MlNNPeHL6Fw
 CGQUxUIhZT/vfVjh3xM3qZCOUQD88c7vwK07RcZsTQ0E1fv2x/RXd2hI5j6wp3oBrM6i
 QrXOZzrRKR/95XAGHZMSwdcBLjRI4SVRI1nkMcjcKLUM7+y1haJr+IbLV3kissbWbAgk
 RHt63tCzV0/jUyMWVVyNxYHdvFGTDsA7LzTGv3LfiQZTFgiSh1Km7u2PNKJHYyM561wj
 Tt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549390; x=1787154190;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c02fVbhAOudqyZ1yr7+yFyrl17CR8xGkMKQ8YOwRWdU=;
 b=lTNt/h+dLcakb4F6EdYhq/6MduftmXjA09LJfAoRxTLnKi9b/uaiB9Nlbshz0f2PPl
 h1mWAwjmTXYUCcOoKYPCKYUQzzxxI2SQ9DerVpPXkB3olP0aNjr8x9efjNb2CWonv/3a
 sia+7Gj+27m0KmkuYTkCqC4L+HUHJhxnGiLtTkdp1cA6nanLhtDNYG8lkTzZf3tWC0sD
 oAgdZ0FWu5ClCC76oEuvOSkJfYJ48/caS6RWuVxOwPnpS7iNfgkKmSdr1wI2RmyjOPSN
 KoS/H6rrw9qxapjWsf20Kcj76/03JgWGB5DIz9sQYf963Y1WHt7N9bY7ntNVO3U3d7GO
 rSiQ==
X-Gm-Message-State: AOJu0Yx6qv+Mo/B/ZIEy093IyoF+AKuYTOp1gFOlOp1f3gFCdGWIBL1X
 oPBuxgsWdyWBOKRl/wXgnn7zpdI2741qhT2kdZJoy3211xBMqSf5/pBaOYZVcug8bXgscqagtxb
 958M4zb1j4Wp0/Y+Xk3DxZ8gzo7UXZu7FD5CSiJBsJVG5jK+6vTt1UjL9PsqDmIe9bw==
X-Gm-Gg: AR+sD11A+g4UNWqj+awevQhOJbQLxjL9LYMGnv/1U5TLW2iJjhwCNdAmhrD6lAcAxtb
 i6ku1hoZNvJ8wz+dt3qeyKTCwlirRkNdnoaqLFirDudO9m/JglvxAw6Gp3L+1DYbM/ptGtXA0Rj
 ZvuZ9XSFtw/FRYS6X9/A6IzO7+mc6rXneEXf7Bo2JmEeFes2YoQbjlcnVCsRUCVE7aHZk803Vco
 PT+33hLopK96LCXBECoqLNYU5tL/gx48unC855OpOSXpOlnRrwyt2C+uptRHkVxc/3O+3qBRUe5
 4nWajNG1vz6SRI2dSBkmWknCHyIKJ9UCKFkpwmmb7Vp+C8njORrT+8EdacwPrjn5tOogo6/XE9F
 R6XkCeINrY0R3DOp442xUnO8ILPZ3yegh45L/5vg1qnoqh+MB
X-Received: by 2002:a05:6a21:a342:b0:3c3:a140:9392 with SMTP id
 adf61e73a8af0-3cc3f20dec6mr8139821637.0.1786549389911; 
 Wed, 12 Aug 2026 08:43:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:a342:b0:3c3:a140:9392 with SMTP id
 adf61e73a8af0-3cc3f20dec6mr8139764637.0.1786549389466; 
 Wed, 12 Aug 2026 08:43:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:43:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 21/41] target/hexagon: add GVec override for HVX vmpyih
 multiply
Date: Wed, 12 Aug 2026 08:42:00 -0700
Message-Id: <20260812154220.1029828-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: IEqWf_8WTiuBf7PPhhXfZ73Z-C6oMHgW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfXw/YWmCu+HLWl
 ZggUCozST9I8DThUMWizpZE0LKJru0lFxXa6Ue5Lliew7SKH2ivIGLYCto1MpghVRFhLdz8jr9x
 1EdCKknyYOK9i00MNFDb4WIX6lhXclsDmXTtkP/oRyDQ0dWlU6qOjnQWLjWdPBpAFZFy+7q84+C
 Cp9EwtgEjRH3fXheyAU3QoXhkVJJS0qhqrNw9qPTOltkwqvcjFOjeHWhtQcDvmpTzL05T9Vfs2x
 dStxqMnX07921hdrvY98Hg/ebLRiRnuas/jtlh8mwEnYuvRWrMkWIFhOSG7vSRdcLM1NtHHFa1Y
 RYJpM7pKIOrOCaYGDjWbbNvb6D/IN7t+V1FQt5ZwqlyxWTWAXiMEEVJfUK/qCnXMxPp5KIUeJ1u
 /qfVLOR8phXED7g3H7h0thu2cMFetFVuASAPXMzBMP2QArgoyWNiCWtFt9jRFaAL6mJtIbogBaD
 Z5mJUZ/1HLcjP9rGgWw==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7c948f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XUVkopRKjuBywFHujjMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: IEqWf_8WTiuBf7PPhhXfZ73Z-C6oMHgW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX6Ek0Ny4lDAIn
 Lu0pam/lxcb+Fky6lm4ljG7OvhS08Qgwza3xMALXiZpbwHJ0/FVjMzGFNWREdsOUKe56TeMfbxj
 +Jy2LOGy3G7AdyCpQtQPEX9Vqcac/ms=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120128
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA4MDcxNTIyNDEu
MTU3NjMzNC00LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbQpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Z2VuX3RjZ19odnguaCB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oIGIvdGFyZ2V0L2hleGFn
b24vZ2VuX3RjZ19odnguaAppbmRleCAyODljZTg5OTU5OC4uN2U1MzcyYTc2NDIgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZ19odnguaApAQCAtMzIxLDYgKzMyMSwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXNzZXJ0
X3ZoaXN0X3RtcChEaXNhc0NvbnRleHQgKmN0eCkKIAogI2RlZmluZSBmR0VOX1RDR19WNl92c3Vi
dXdzYXRfZHYoU0hPUlRDT0RFKSBcCiAgICAgZkdFTl9UQ0dfUEFJUl9BRERTVUIodXNzdWIsIE1P
XzMyLCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2
X3ZtcHlpaChTSE9SVENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2ZWNfbXVsKE1PXzE2LCBWZFZfb2Zm
LCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9C
WVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCiAvKiBWZWN0b3Igc2hpZnQgcmlnaHQgLSB2YXJpb3Vz
IGZvcm1zICovCiAjZGVmaW5lIGZHRU5fVENHX1Y2X3Zhc3JoKFNIT1JUQ09ERSkgXAogICAgIGRv
IHsgXAotLSAKMi4zNC4xCgo=

