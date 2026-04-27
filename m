Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E56FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHQUP-0003LB-Po; Mon, 27 Apr 2026 14:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHQTm-00035p-7O
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:14:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHQTk-0000Gl-DA
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:14:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RCYRJT429032
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 18:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6bjPWz7DNRn+g9rvzEysQdLFoOcNGafm3fwSCPkxSh4=; b=CTGbLyPZ4ogxENtn
 Q4yF8g0OMDBmsi0Bdnw3v9ipr7YwssHhuTQsgluYCviqzW0h5Muv5/Bo3Z9hLkBg
 5Yy/c+j7pTPTODswViHgigI5rZcO0ZSx/yDdKXVuiWI/Tmd0bHhVr7JrRhOipGMu
 o5u5s47TVKoHQlUI8YIP008/VjVTDpWLqVOgvd6fatLVtPEqKTnOzSgTlefDJ5w+
 ojmw6GmAWcBGmmSt91sqdc1bE1Y0HCr5IC2Wg+wm3//KhJjwWLANNHuiAHQy58+4
 q4eNBAix6LAQdoLJdnnGcIWe4TQsP2zfUKkUQgW5lQbwjpmNlgNruCjtFnJYe/1S
 o4UmvQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7x31akj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 18:14:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so13760162eec.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777313681; x=1777918481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6bjPWz7DNRn+g9rvzEysQdLFoOcNGafm3fwSCPkxSh4=;
 b=KM1zjoECGYsCS3NHEhh0fdHhIXrrnlSy4vy/Kdo1Pb0rJGiLY9bmVoi13VC5ZduqAs
 CcNxiGO8nYAcIVX1yT8kFdyTRSKwu8QmKuksqpe1Uw8k5GjRVfDIYdqozMh0iXagzmie
 0yKEW8pIfd3GEKvm4B8zxJ0hmNnK+5e1K3BQtIr9zhiAzkQUiaIo43RHnhWhjRWSEyxT
 RaTD8jCyVWdmX678Rp/cRWIJwG3PZcp7MxJV/kf9mIemTjjnP1cLYp0bw/8X2uUUdt6x
 7a9YN8AAdXwxMJnJUQy826PsD86uNXAthG8IUEIpFreeuRrhMUi0Ug2iOR+0czFYqa+G
 qnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777313681; x=1777918481;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bjPWz7DNRn+g9rvzEysQdLFoOcNGafm3fwSCPkxSh4=;
 b=Eg6o9oEmo4+qu5CJUSOOr7QAeuXPy7Sm8ML1dAM0FGBaOWc8Yxv1McjEbD1kmplkK5
 dB1xZT02WegCmSVi6K/e43mAOp3wpxS70bfG36n5szTtK2Prb1RekGdGUALDxPdcvWlK
 bvIf2rGFiVYJKSg1IJ+zt6JhNS7aK/VrL/dRDD/txrmleEsv+4LQ6ocngZAUaYDo7i8O
 pcAI7KUjxyOX/ZSsEkgtxlFcGt1MpYTLBcI/7rBDuQ4p38/wscze8ZfCIwNLEdTMamSv
 jWrxxuGcp2se5hQ+pFpgnKi2R6cyQb92vTy0D7Ek8Uk3U6KUjs2Li0iYLNibZyatxSoX
 gSAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3uKsyy+HZKm2weNKLmR5FzTu2pPsDELPCyfqVkNY4WiVxllfJNgpXRHJRhcK6qrCPVqgRzaMCTZpF@nongnu.org
X-Gm-Message-State: AOJu0Yy1cOdPM/UlcXm3gVpDKXctK3XZ0HjM77ScO8REsgPrEXatpl6e
 s5s54dK7emJtpJ1ePEibRLwQFTDfpgGrqgsrKv/VlKxoURURcabAGr7N5nhRCvU1UoPgyO3r+r7
 1V1mQ3BrrzDzjZOyWpMznomSoiwCcG6f7xBcL1gnGfqDcus10Fit6IBBLPA==
X-Gm-Gg: AeBDieskvnMi7qoZgT0JTe2hs8HQ3zne9ANKga5hBuHMpoVjLTK03Rrf25+y3CXwPen
 Aj4gb4v4vF5oNYhmQE7QAV20mVI0Io/phjEM5+qjYN6DMVSUPW7SqCW7ksGQHIfHvOnhSVXzlVi
 q5Kr+aV84XTPZauTrw+Ppk6wZpD9CmGiey33rhojLCwcaKMVDwMJghNFaDX/wD7Qf+7ZD1P8QPP
 eDXNyfFmct/tq6w2fpTC8WWD1hw57LrrnWd1vokRylB6fo+WN7QIzENf3hqiJQ620/DKMNmFTqF
 TMoTqhwi4XpoC4gvKiFJFXWv4sw/CKLN3K1136HcqpHntOhxdodVeYtTdATa4MJRnB1uVxHgUap
 k+BGiJ7xButRBMIVsPUtWapLRGJKpDiQXH/ALIxxKCv4eeg6Bn6o5GkXliTGT+9PdlgAG8Fb1e/
 rEdiqv5HKYJ4Jl34aG3xAKiTJC
X-Received: by 2002:a05:7300:642a:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-2ed09c154bcmr36292eec.13.1777313681232; 
 Mon, 27 Apr 2026 11:14:41 -0700 (PDT)
X-Received: by 2002:a05:7300:642a:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-2ed09c154bcmr36271eec.13.1777313680554; 
 Mon, 27 Apr 2026 11:14:40 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53ccce460sm44706858eec.19.2026.04.27.11.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 11:14:40 -0700 (PDT)
Message-ID: <b8da7f91-6512-4f24-a120-8df5d22d3bb5@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 11:14:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/tcg: Add test for /proc/self/task/ filtering
 and tkill validation
To: Ali Raza <elirazamumtaz@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, deller@gmx.de
References: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
 <20260424-master-v2-3-8b50b5c063ed@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424-master-v2-3-8b50b5c063ed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE5NCBTYWx0ZWRfX8OT79UazlV73
 jr01QMxI3aJRRPKyEioq1Jf4P8IVyN+Ah0UJ78tYCdz7kkVFI06CAvdLCegKpaPzA0fAlN6sd6f
 qBxp+jmmrQuypg4qdUS10NvVSYp+BSufrZXFnvy62H3OPYR4DtvUm+NUl8W9mu7FXLNTUl80Yxa
 j7NOzgLu9aPsy/frupG45XoSLT6M0TNiqHzT/dgUZcmusmtviiFKY18m/Av3pShbFhK5BXXJu3o
 WTNaXwvx/vbNjPJfIEM1/U/oN4ZwqxXT53qziSsHz+vNlz+51eA/fZbhIiJq6a/mUjlqI1hWpz7
 vzygWCimtfGOJdUDTfDiUEpIb8L5qJ69ObCZ+oTUXBFrX5tkpReGQT0JAWnrxuy+RIsAD483yHW
 9KMjd8oS7q0AOHCIeIp2v2InaUb8m0EKNY89C4BY9psdrSQCv04az6oU6T+7nlPBsvMBNDUwWVf
 NhM4I1OqKNzWxoVJtXA==
X-Proofpoint-ORIG-GUID: RCAapRA7zjf6hXWjVXlJyQgK6irdzJao
X-Authority-Analysis: v=2.4 cv=AJEsYPsu c=1 sm=1 tr=0 ts=69efa792 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=kG0x-5ay5tX3yjYrpVEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: RCAapRA7zjf6hXWjVXlJyQgK6irdzJao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270194
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/23/2026 2:36 PM, Ali Raza wrote:
> Add a multiarch linux-user test that verifies:
> 
> 1. /proc/self/task/ only lists guest threads -- spawns NUM_THREADS
>    pthreads, reads the task directory, and asserts every entry maps
>    to a known guest TID and the total count matches.
> 
> 2. tkill(guest_tid, 0) succeeds for all guest threads.
> 
> 3. tkill to a non-guest TID returns ESRCH.
> 
> On native Linux this test trivially passes since there are no
> QEMU-internal threads.  Under QEMU user-mode, it exercises the
> getdents64 filtering and tkill validation added in the previous
> two commits.
> 
> Signed-off-by: Ali Raza (@locus-x64)
> 
> ---
> Changes in v2:
> - Hard-assert ESRCH on tkill to a non-guest tid (was a printf).
> - Add tgkill coverage: success on guest tids; ESRCH on a wrong tgid.
> ---
>  tests/tcg/multiarch/Makefile.target         |   2 +
>  tests/tcg/multiarch/linux/linux-proc-task.c | 193 ++++++++++++++++++++++++++++
>  2 files changed, 195 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

