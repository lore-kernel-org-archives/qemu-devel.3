Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB59FD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Aa8-0001h3-4j; Tue, 10 Mar 2026 23:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZn-0001aI-A2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZl-0005CH-QY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:39 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B2gsxk1572954
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XSbtoOook+EXocY5SyUyl/bxt/QwIXQKJrpyrR5U10g=; b=IqNUNZwBO9PLuAfc
 1jRKWnTrffCfjgFXqOMX4l2hAAjQXbEmKAjc1SmbGooeWZc+/wNzRSlhuvMrSAaR
 OsT5DTaD5HYjQDZa49B3lWxvEWHG+YFcMwiSPNST03JsI3I4d6ggvpbzCL4m3eos
 cVEfFtnknc/DRaie56MT+4sgnXSnQ5jYg9fn+G+rfWNsWtkYIw+slkrEg8rMgKOK
 /1vQSX9nP47nU5SXlgG5LtLt8Ak/VJamX8zHjZT4YOXZBUiasAOvwfoYr1kuEhH7
 jzel5TGR5CL7fwr2uGqEqQYmusLdq+Lg+wBtInHBO8k+goyWs61mzHInh1e6H9uV
 Pb2QSw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqgk9tjr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:36 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d748bc34cfso24445832a34.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200976; x=1773805776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSbtoOook+EXocY5SyUyl/bxt/QwIXQKJrpyrR5U10g=;
 b=hxigf3ujbKPx0b1wEtlbOurGoWBjhaRZ1azdl8UT/Is1div8ycHO9cElVItybmnHDV
 F34RQqvCzEoQCVAU9BYkpqlAlzGYN+6fsuoxnF4WmLe56q3bzY/95Dbi0s5oD8x+/4eo
 QWcoFDBy1kWIqMVC3HXpghCB6z22IlQbwDlWAxyI0fbWPMczb9lz4mila6f4xI1W2HFc
 xODcnzu3hWbOYBYUhVnMIm662qUqyU9pZk6gjfRdDknfGbeXwkh4foeRHHuTdI1vD1rF
 TOeRbY22uUUCuRqBtDfR48FcxbKsSW9vOu/vXzmssXTvsC01eqJKfqIotIPRrhFmw3Lx
 R6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200976; x=1773805776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XSbtoOook+EXocY5SyUyl/bxt/QwIXQKJrpyrR5U10g=;
 b=IXtdugLO8Ga0eRWEU9pvqGsy3ryzplEGpVqC5+DY/KKJ1rhqxe02SLB6+dSI8X8JPo
 u9ztt7kxjXo8Tb1yAVJS8S9nNTZYsAcMhjGeWaR5p/hfN+4Q+AAAP6Spo7VURnmfUt9a
 wJQn79IQn36kLa9hUFc6gLFhB9Wl7ElcJwucBWpY9twWbQCZP7Kt68PWQAFWnvKLZZoa
 vFiu3WJC8iUosClmVmw/7nXu4xInY97ML0YS0x/vBHl0wvEVxYVb/I42YHQIZCWc+CLz
 Nz26aowXZ1OnfV/Ffsyw+EDFffwYDOXMs2tkAf6mB7j/mbgFVidq4iEROLDe0sd/bsPX
 EbvA==
X-Gm-Message-State: AOJu0YwRJrKzqDKyTzkz0ZHh0udAft09X0y48EQCb109OksSqBrk8qQl
 INeDtSz6bLzSENIKbjk4FVOLBuyfGozPmdROGILgu5uP1BEveKQH/yiu1F7FGZbRoL0Qnrt4ucL
 RS7j6VbcstNxfrsmF38RWwieW4OtQciVM+PRhxzUI6XKF0R3xa85hs87Jds7DNRoupA==
X-Gm-Gg: ATEYQzxU3qpEAO5TPitXQ8f37Azkuwzu7hHzZuuLohfXnVXG/Csj6FQ8N3n1xnE08Dd
 4DmWwejyBirlFtijLUk/lEbkT7dV4zMwBAan+wqm208Slg7+TRhGH/H8pvt4IhcgeHpbfJ+EShq
 vW+RSrxDZSuk4jiYJ/r/mON2iDdCHuInmgCAZJxZqUe7OOpdWsfT/rTVlWF/twWJ97lDv5Ub6TS
 +9fXR3751Fs3q2YUjgbsQYzy1Y+ro+PcUOTQbPnJtxVOnGliU7MurfZa7i9gFEDEQygHQsn1pdA
 GGunfmYYvvRfJPaQBNF9+PxtXGvbQcXYeb267uvLaGzZrP6FBTSTMWP4nAFzwx82BYvWJ8XtXRj
 HJ67lP+lKfTtb6v5rJNbBlcx0p2BW32Re7VqdKjVNtNOZEAhw5lSapMlAiG/H3N3hs+ERhg==
X-Received: by 2002:a05:6830:910:b0:7d1:9217:94e with SMTP id
 46e09a7af769-7d76a6dffc8mr987686a34.26.1773200976184; 
 Tue, 10 Mar 2026 20:49:36 -0700 (PDT)
X-Received: by 2002:a05:6830:910:b0:7d1:9217:94e with SMTP id
 46e09a7af769-7d76a6dffc8mr987669a34.26.1773200975812; 
 Tue, 10 Mar 2026 20:49:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v5 06/35] target/hexagon: Suppress unused-variable warnings
 for sysemu source regs
Date: Tue, 10 Mar 2026 20:48:54 -0700
Message-Id: <20260311034923.1044737-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 7qIg4a6yA09miFBBt3CNjdIx-5dSPwn4
X-Proofpoint-ORIG-GUID: 7qIg4a6yA09miFBBt3CNjdIx-5dSPwn4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX7+Jlg/6P2qsW
 i56BGZyEZ+qpiMyN0f6RvInhNtX0SfRWxqGeheaiHyZHOXaNXFeYRSSGaCyKq67mjQho5qa0/aP
 Nm4j6tR5fqN+ef6JNxVil5uE/vbT9wVGLXCztH99e8/omJQc2629SkbyOAwyFVZxLKmXIfhx1bu
 AU9tXDYwxc6Pav861gcg8jpMAsh513m1uyaJgYy5z/3usyQhle0P43tcCLSR3AF6E1k4W6XYxDG
 6xcfu8y6DoWTFhV1skEUhbfAnxuWDQGBO3yQCiBN+1Us1JhAm3A/uRrguliaFcYYUL1uDSdefvT
 s2LN0f4AnTo7+E/tRGZGNkVW6X8ettEQTwXlk5AY7pcBsa4EoLCq1p487+qeJwcZOL7jmW1ygv5
 k7s1szoXN+mPRUcKlOzCmBVVGqnj3qxuQzDPJuEQJnI5CGVBImFUVKNIi8s0DZNigRyQkvRpsti
 6wC3/VoI0H2IWCW/ZkQ==
X-Authority-Analysis: v=2.4 cv=M4JA6iws c=1 sm=1 tr=0 ts=69b0e650 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=dvhcR3axvtdXbCCTPW8A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

VGhlIGFuYWx5emVfcmVhZCgpIG1ldGhvZHMgb24gR3Vlc3RTb3VyY2UsIEd1ZXN0UGFpclNvdXJj
ZSwKU3lzdGVtU291cmNlLCBhbmQgU3lzdGVtUGFpclNvdXJjZSB3ZXJlIG5vLW9wcyBiZWNhdXNl
IHRoZXNlCnNvdXJjZSByZWdpc3RlcnMgZG8gbm90IG5lZWQgcmVhZC10cmFja2luZyBpbiB0aGUg
YW5hbHl6ZSBwaGFzZS4KSG93ZXZlciwgZ2VuX2FuYWx5emVfZnVuY3MucHkgdW5jb25kaXRpb25h
bGx5IGRlY2xhcmVzIHRoZQpyZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgKGUuZy4gR3NOKSB2aWEg
ZGVjbF9yZWdfbnVtKCkgZm9yIGFsbApyZWdpc3RlcnMgdGhhdCBhcmUgcmVhZCBvciB3cml0dGVu
LiAgV2hlbiBidWlsZGluZyB3aXRoCmhleGFnb24tc29mdG1tdSwgdGhlIGdlbmVyYXRlZCBhbmFs
eXplIGZ1bmN0aW9uIGJvZGllcyBhcmUKY29tcGlsZWQgKG91dHNpZGUgdGhlICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWSBndWFyZCksIGFuZCB0aGUKZGVjbGFyZWQtYnV0LXVucmVmZXJlbmNlZCBy
ZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgdHJpZ2dlcnMKLVdlcnJvcj11bnVzZWQtdmFyaWFibGUg
dW5kZXIgYm90aCBnY2MgYW5kIGNsYW5nLgoKRW1pdCBhICh2b2lkKSBjYXN0IG9uIHRoZSByZWdp
c3RlciBudW1iZXIgZnJvbSBhbmFseXplX3JlYWQoKSB0bwpzdXBwcmVzcyB0aGUgd2FybmluZy4K
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IHwgMTYgKysrKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9oZXhfY29tbW9uLnB5IGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCBj
ZWI0YjY4MTJkNi4uMWRhZjcyMzlmYzQgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9j
b21tb24ucHkKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMTA2OCw2ICsx
MDY4LDEwIEBAIGRlZiBhbmFseXplX3dyaXRlKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAg
ICAiIiIpKQogCiBjbGFzcyBHdWVzdFNvdXJjZShHdWVzdFJlZ2lzdGVyLCBTaW5nbGUsIE9sZFNv
dXJjZSk6CisgICAgZGVmIGRlY2xfcmVnX251bShzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGYu
d3JpdGUoY29kZV9mbXQoZiIiIlwKKyAgICAgICAgICAgIGNvbnN0IGludCB7c2VsZi5yZWdfbnVt
fSBHX0dOVUNfVU5VU0VEID0gaW5zbi0+cmVnbm9be3JlZ25vfV07CisgICAgICAgICIiIikpCiAg
ICAgZGVmIGRlY2xfdGNnKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xf
cmVnX251bShmLCByZWdubykKICAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXApAQCAtMTA5
Myw2ICsxMDk3LDEwIEBAIGRlZiBhbmFseXplX3dyaXRlKHNlbGYsIGYsIHRhZywgcmVnbm8pOgog
ICAgICAgICAiIiIpKQogCiBjbGFzcyBHdWVzdFBhaXJTb3VyY2UoR3Vlc3RSZWdpc3RlciwgUGFp
ciwgT2xkU291cmNlKToKKyAgICBkZWYgZGVjbF9yZWdfbnVtKHNlbGYsIGYsIHJlZ25vKToKKyAg
ICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAorICAgICAgICAgICAgY29uc3QgaW50IHtzZWxm
LnJlZ19udW19IEdfR05VQ19VTlVTRUQgPSBpbnNuLT5yZWdub1t7cmVnbm99XTsKKyAgICAgICAg
IiIiKSkKICAgICBkZWYgZGVjbF90Y2coc2VsZiwgZiwgdGFnLCByZWdubyk6CiAgICAgICAgIHNl
bGYuZGVjbF9yZWdfbnVtKGYsIHJlZ25vKQogICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJc
CkBAIC0xMTE4LDYgKzExMjYsMTAgQEAgZGVmIGFuYWx5emVfd3JpdGUoc2VsZiwgZiwgdGFnLCBy
ZWdubyk6CiAgICAgICAgICIiIikpCiAKIGNsYXNzIFN5c3RlbVNvdXJjZShSZWdpc3RlciwgU2lu
Z2xlLCBPbGRTb3VyY2UpOgorICAgIGRlZiBkZWNsX3JlZ19udW0oc2VsZiwgZiwgcmVnbm8pOgor
ICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCisgICAgICAgICAgICBjb25zdCBpbnQge3Nl
bGYucmVnX251bX0gR19HTlVDX1VOVVNFRCA9IGluc24tPnJlZ25vW3tyZWdub31dOworICAgICAg
ICAiIiIpKQogICAgIGRlZiBkZWNsX3RjZyhzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAg
c2VsZi5kZWNsX3JlZ19udW0oZiwgcmVnbm8pCiAgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIi
IlwKQEAgLTExNDMsNiArMTE1NSwxMCBAQCBkZWYgYW5hbHl6ZV93cml0ZShzZWxmLCBmLCB0YWcs
IHJlZ25vKToKICAgICAgICAgIiIiKSkKIAogY2xhc3MgU3lzdGVtUGFpclNvdXJjZShSZWdpc3Rl
ciwgUGFpciwgT2xkU291cmNlKToKKyAgICBkZWYgZGVjbF9yZWdfbnVtKHNlbGYsIGYsIHJlZ25v
KToKKyAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAorICAgICAgICAgICAgY29uc3QgaW50
IHtzZWxmLnJlZ19udW19IEdfR05VQ19VTlVTRUQgPSBpbnNuLT5yZWdub1t7cmVnbm99XTsKKyAg
ICAgICAgIiIiKSkKICAgICBkZWYgZGVjbF90Y2coc2VsZiwgZiwgdGFnLCByZWdubyk6CiAgICAg
ICAgIHNlbGYuZGVjbF9yZWdfbnVtKGYsIHJlZ25vKQogICAgICAgICBmLndyaXRlKGNvZGVfZm10
KGYiIiJcCi0tIAoyLjM0LjEKCg==

