Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BBCCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbncq-0002oF-4A; Mon, 22 Jun 2026 19:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbncn-0002ne-P3
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbncm-0002Eo-9D
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:17 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbNPv2122914
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=; b=mUTAGwVXDF+A1/gu
 7QaXIrVbT/T5A2/yRZQZHEbogrmscU+9BT75s6M8BRHSb+fez2Br7jRvujzxUR5A
 CEadkVRKeA4EKmRqO9lHyzGwx2aYpriSqmgB+Fa/iv791/Ayem3CXbC9DzCZC/3y
 CGujRl9RYs+p/gOT/A5By2B6rx9Y5J/BRkgDT+7DFbv7o0gV2t9HQ70GrJ2PudjV
 NrDXO0TJGn1f8tLBFDLEMmaCM/Ul2Y3gk4ojue/91d3JQ0EHeC5UCrVCu6eFewQB
 VZ1JAKjCccgABmzAujgcWwOOKbeaHthSGf7VFkdiZAwgUDvux5SD5KRnaDAIj5hK
 3r8pEg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n421dh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:15 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139871a52c2so7023229c88.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169214; x=1782774014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=Xaglzbp149zx6qF3UEyEMoS7sCv1PnoOydbmqH7JBEAqgyEpo82xYJVmLf0jRN8TuE
 1bRaP0KlqdyB23WDzm9+1gzUaIJDKutrsJPUzfDw2zlELlv5lwGSvbSvsW5oNpaROmf2
 Mwb9hfhTimiI/FG0vyUBdc4EEciUKGTCahjoTj6nKRfw1MeWX/ieptCthooVaKs1R3Rq
 uWH7c/FL0X0CeSKuhRH5wSp1vyO5rAWXIZKRcfC2BiEv9JJd66lZ5pHAgST9hIqt3L3W
 rHWOTzAtLL30ETSaNgKNZErnBGGO8/Q8KyovK5qUt25/0wRFNPYCQZiJb/5eK2sNy9bq
 84pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169214; x=1782774014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=iBbVTh0N9Mkyrszh8De7xJq4TlK1enjpkQBnSLi0G/eyu03rUmuxel1dxCIB/CdOi0
 vI3/rnG0MPob6cfrXzX3hVZ81x/MtlMrPAzmaIkfu6L4xY52hDuBA++vuduj2O+ffzGf
 axnGA5Eo35gKxBydCNZYosPTEolgF0de7oyj0LWu6uo2ZsW/QtRDTeZ/CE4U5ROiXvxi
 nrN2BuFsIXUIUUQOtGyKryqT+nc/AUDihTnwr1zzrVBxhKsHz/8GbEhy1W7fMbtN6zer
 W26aDq7TxrwbwOqevbBhClfPQiZHgHUu7idpHsp5/f3KSmjhu5QnBax8TwmnjlAXzWOg
 VrhQ==
X-Gm-Message-State: AOJu0YyAY4BvkgH5Ys8Y0RM24RessQcx0Rd+TOMkWmNDDGrIzPLJpT2n
 xkV2xPLte6Tbg/XW1JjmZeHKfXqw91sC2wRhXg9/fyWlhNNwmt3kl5x+IL/pGgxlgI77d302kcP
 FTW2GBrnTeKpuW7/eOSc0sAZLUoBaDXuDz7aKnSmdUgqArJE2+pD4lFHD6dMNF/LdcQ==
X-Gm-Gg: AfdE7cn2mSG8a0KM8r0f8LxjUnuIcHWX2DSQ9kFrDgiZFdpIwjooma2yueoBtjzJ3+R
 meUfTokVbtjiuUuXtnK4cBqTW+DU/FxNj4cf0PpnwMObbR73gyR7RSL9qvOYqnBMAM4pKQynK6v
 9EpIQNf7BOdNJedGbwuOPulzl+3JTBvtrLp+NANnMs1bNgB78Ju7dMuMXCpSsqEEHbKt2Qn0InP
 JW3Tgy8uK5i6DleunoSH/xX9ANmFoaMspYTGr/SCsfwEou4KuX9DvKNgPIDN7IL+D+05WsgnmP3
 6oCzYO4GV64mNseuPwDl9BMnNp1GDF84FPHfXvXlJTK+UJcvZUoq4d4ufSexnm9KJXfpE2ywwL/
 yWzf+yeDmtkftrryHQQ/JbFf3B7nTmCsMocoXNhXJvQ3jcgJqwwVAai/o1pU=
X-Received: by 2002:a05:7022:f68f:b0:136:b50c:c0e9 with SMTP id
 a92af1059eb24-139a386ba66mr8588520c88.21.1782169213931; 
 Mon, 22 Jun 2026 16:00:13 -0700 (PDT)
X-Received: by 2002:a05:7022:f68f:b0:136:b50c:c0e9 with SMTP id
 a92af1059eb24-139a386ba66mr8588503c88.21.1782169213393; 
 Mon, 22 Jun 2026 16:00:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL v2 44/75] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Mon, 22 Jun 2026 15:28:33 -0700
Message-Id: <20260622222904.607771-45-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX3o0pSTZ0nVqm
 iRaGeJBkVqVwD93Nifj6jZzj0UivsKbzCITlQdQPnjMTm7rEM5q87f+ctD0Uw3QulWoZp7vVsUu
 rnARO+7z5dgtS21fbuWRDZ2iZNAb8P4=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a39be7f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RKVJoAg1yBLoogzcrgwA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SjkChdvS4TcvleJ9d06yOJtgDJj4Uxaa
X-Proofpoint-GUID: SjkChdvS4TcvleJ9d06yOJtgDJj4Uxaa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXxwsVIooOey7v
 e1nefm0UAmSJe1dCdKmX9MNtGpe6IJYqEV3ofaLvQx7INtNJaaPLzRf9BmmiLVxSMhFhuve7tTe
 bxMZzGi2/Wc/pOwGqcK3j3q9opmX4JVRe9xt0BK1U9MCHu/tfsu/mBj3gL1GHAniU1sQcO9HtUd
 2Wc0xHghfJdLiIAUfg4Bs+s9ef2SuGaMe4W9TaA4RSAVWKsEQKlThrqyJB1r7nYWSZGp9n+Hi5p
 tw5sdY5f3iLK8Zieewzoo2H812SCCY8Xct11IrEzcYDieEV3OFe2Jh8Sk/1Uw/PmykALBJlmQ91
 EHEFjRij0AwPrvPb1oUIXKcQ25Dk+YJ1DQVmfdIeNGYRVoSoqcOrNbBOqEgIj9Ivzc/CaqdIE5h
 mXWN5NKhTnT4SqnNS7X/yNvUL4aOfXEiEw/FwFOsa4rVteHJzYm3245OeuXgFLTDAyOU/TYRX+w
 yONDgGYB1fVehj0phPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220221
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxpbnV4LXVzZXIvaGV4YWdv
bi9jcHVfbG9vcC5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgYi9saW51eC11c2Vy
L2hleGFnb24vY3B1X2xvb3AuYwppbmRleCA5ZjU0YzdiM2Y5Ni4uMDk1OGM1MWZiYjMgMTAwNjQ0
Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4
YWdvbi9jcHVfbG9vcC5jCkBAIC02Myw2ICs2MywxMyBAQCB2b2lkIGNwdV9sb29wKENQVUhleGFn
b25TdGF0ZSAqZW52KQogICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIGNhc2UgSEVYX0VWRU5U
X1BSRUNJU0U6CiAgICAgICAgICAgICBzd2l0Y2ggKGVudi0+Y2F1c2VfY29kZSkgeworICAgICAg
ICAgICAgY2FzZSBIRVhfQ0FVU0VfRkVUQ0hfTk9fVVBBR0U6CisgICAgICAgICAgICBjYXNlIEhF
WF9DQVVTRV9QUklWX05PX1VSRUFEOgorICAgICAgICAgICAgY2FzZSBIRVhfQ0FVU0VfUFJJVl9O
T19VV1JJVEU6CisgICAgICAgICAgICBmb3JjZV9zaWdfZmF1bHQoVEFSR0VUX1NJR1NFR1YsIFRB
UkdFVF9TRUdWX01BUEVSUiwKKyAgICAgICAgICAgICAgICAgICAgZW52LT5ncHJbSEVYX1JFR19Q
Q10pOworCisgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BS
SVZfVVNFUl9OT19HSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BSSVZfVVNFUl9O
T19TSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUOgotLSAK
Mi4zNC4xCgo=

