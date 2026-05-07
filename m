Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCE2CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 19:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL4KM-0006cG-Cg; Thu, 07 May 2026 15:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wL4KK-0006bg-V0
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:24:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wL4KI-0000Ia-N1
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:24:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647IBd7Z2770992
 for <qemu-devel@nongnu.org>; Thu, 7 May 2026 19:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JD3Okd8DQ3GxIiHKqOVQvShu
 QuH73oAxFAyGID8iKWs=; b=IDS6kymeienCkPE2WHD1aIN6LXnstDZFDQx6ImB7
 kQwywlLlzmcrnMuaVh2kqFGqywsQUkbmwLttzu2AIr3A40xyoLHJye9o7JFaSUzX
 X6rmjVUrmubZyP/FD5tzdEfEouOmLdjcyawes8obCphNVC5y623YNw0Xgu43hiJY
 OW1NuJSqSUddvO7JGDQD55BQeDXvTDwuSSw2VRyYxkzvhdWO4WB4nQ5vqgOBE6RQ
 DVOwbq4WB8pdernq7X20vSQMzTP9F72m+rQcj5gaL9PL0zU6EsmqjmK2ZeF2b+jA
 nl2chANrnFZRXi6E7bMBnb3s6gmyAVj9CaV6Gh3Ftw1N/w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0yt5g88v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 19:24:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so1420445eec.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778181839; x=1778786639; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JD3Okd8DQ3GxIiHKqOVQvShuQuH73oAxFAyGID8iKWs=;
 b=AfuoR27eEWY0Uk9SVq4DqmMOJcbhhT4QyXOUkGDG7aAi2YBjgv9/D0UiPcLxIEc6LJ
 MeExfkevWy8I/cbOLnSGAGkv+hVEYI2xTBWuY7VSMaYLtXwJTplXy5MHYDAXEoPq+LyK
 E8K/ZybAvT4yz5tyuOTfWzvoIM8x0mWBjRlBLOtjiMdzD0iiL/5A0/IyUx3pDVQL9Yta
 Ldqt/ZlAULcs7BExhnKLVFx8ps/j58d0egX+uxNQIiFBDQMFDgT4OMSbudD19YAAhSLC
 3wq9NIlwRpnZghFjM1LFeArf3+u7eUffy11Z+okfGJ5JubNvJASqMCpFCkrCislCvDEv
 NbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778181839; x=1778786639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JD3Okd8DQ3GxIiHKqOVQvShuQuH73oAxFAyGID8iKWs=;
 b=gCFsPgr94HSdBdmwBP6QGsyrMo+aJ2cYUUIXRwbba/jDP6qu8m7A69hx4yIisL5rqZ
 ax/VyuYZX6OvC10VDeXORQwhnVvse0w391sSFN2cRnFhZJosHislxQVBC2+Sn+1vn+Ae
 f2foUT9k3PyUOEf0BpfGw7x94Zb40pH49t8zERvV2kua8/DCvfoKlT0hy7l93PuR8Hpr
 Php+PtQbUP/JUqscUxUtiEnGGQrwwFBh0nXU9u9sL1Q6vRaG5QL+ZyRYUxhgM0Ck3xv2
 Loqe5uHP0IXcqgaVgig5I/PLFxkwkpex6oSqCb92/Pu+J3cnXf0o4+bakzN6pT6YwEbq
 RvOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QBPV6wKLnkA+YtoIOULEqyhIJx/a5q2+T2bZUH3Av9UVrBUW7BgUyhoVzvoEyh9/Kb2kTwqx9qHcz@nongnu.org
X-Gm-Message-State: AOJu0YwMCyP98uvji8eSxmbye/3ywimMPONiYIAjOPh0RhJYHImwb9lQ
 PTYalECBtaIxqfT0vpjTZrs094sXVn2U7jtbQTqMBJagXscMWHcSaM+0Mc0FOAgdEmsenQ60ADs
 rCe3RkwxanKKh3RqSCDM08uLSovYzFAc8UFrT1e5090VDoBD9PgPTKCMRkA==
X-Gm-Gg: Acq92OF2La+d6GlRDRgV5voYwpnz75J9a3B52HtbmZLyZAIys09MXPxzj/+AgIte+b1
 xJJuI0T/C981Mt9uFp3TmsqPnFQBL3UXlROow2hGcslFFaxtU87GPm8yQ/9W0cA6xUd5MQeKlPR
 DbdLQhSq5L4fvysZ/e7ltQRPJdPAPukeFIVZutU3har97mgPm2uScpYCz64XA3JycnB3d9F250j
 yfYt88Bb0ADX8uRL6G7vWUEFs2Jjjdihh8KpaQJ7OQqwZifNxl4ZLPcQhOZmk4QxOOiy9zZB2K2
 xK4hCbLffyaUbFE0s2wx0p4dyS34MD+so9pmKx1WbYfdNTyw5WkV6MkzNJJNLnH3YKPMKly/j1B
 VAdH5aNoJA/X0IRxuqwtz9z9Uehv2HqI=
X-Received: by 2002:a05:7300:cd91:b0:2ed:f791:3417 with SMTP id
 5a478bee46e88-2f54aa781f5mr3897809eec.25.1778181839066; 
 Thu, 07 May 2026 12:23:59 -0700 (PDT)
X-Received: by 2002:a05:7300:cd91:b0:2ed:f791:3417 with SMTP id
 5a478bee46e88-2f54aa781f5mr3897779eec.25.1778181838495; 
 Thu, 07 May 2026 12:23:58 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f82b5636b2sm382898eec.3.2026.05.07.12.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:23:58 -0700 (PDT)
Date: Thu, 7 May 2026 14:23:56 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, leif.lindholm@oss.qualcomm.com,
 Fei Wu <wu.fei9@sanechips.com.cn>
Subject: Re: [PATCH v5 3/4] hw/riscv: server platform reference machine
Message-ID: <wazisnbumueun37qskfnjz7n5ioqhpshesebjsczgucjmxxhia@va7avfk77xlr>
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=Dc0nbPtW c=1 sm=1 tr=0 ts=69fce6d0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=Nc591jLmD5Htqi7HrfsA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: mjIc9BYyFEwBeLoeQQJXjf45I7EykS1i
X-Proofpoint-ORIG-GUID: mjIc9BYyFEwBeLoeQQJXjf45I7EykS1i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE5NSBTYWx0ZWRfXw1xTnDTvFW8j
 auFIbugDil3PtTE0lgobPiQux693YteGbyxy09HxjCmEwGVW5jOtlx/81QH2FMq4Kl6LsjA96tn
 XrwONws5Pg6kVeyGBuSqh09jD56cgVROzCkEOJJaluQsH6nqh98n5O/OPKiC3eZUhkEav6Xkr4a
 siW2ZnQ5UH1XZrBlhTg8wjMcmHDkP/9RYYcDGpZ5FEImEej98YXu/4P2KxbSMZ7r+G4O0xUuYqF
 LgnfTU9Uka5FDDDFc5RWp7+m4+4xY5Ji81YyUYAPl4xgRY9/71qwuTRDXnCJBMIuzm2GAEqI8su
 bxbqf+/+EhoOfWSKtRJtEWm7afGBPNeTZNJCPzaUmcDAyGoyGXK/+hiTyV4J7bMW3CDBubRv1uj
 hLq3FNEgwHwrXnmQ7R5DM/258H1HiBdUVh3GUK7g+zy2Nmufz9lZqxxVS+LmpHfM/4nGkZGKU8f
 pV7qFlmMi3Iz2SlY0Rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070195
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 01, 2026 at 01:27:41PM +1000, Alistair Francis wrote:
...
> > [1] https://github.com/riscv-non-isa/riscv-server-platform
> 
> The first line of the README says:
> 
> """
> This document is capturing discussions at the Server Platform TG.
> These are not official specifications and everything in this document
> may change.
> """

The README should have said frozen instead of "everything may change".
It was my fault for not having updated it. I have updated it now, though,
but not to frozen, because v1.0 is now ratified.

> 
> So this machine needs to start out with version support (like the ARM
> virt board)
>

I'm happy to follow ARM's reference board's lead on this, at least for
now. I only wonder if we may not want to use the QEMU machine versioning
support to bind machine model versions to ratified and experimental
platform specifications at some point. For example,

 rv-server-ref      -- new, bleeding edge platform implementation which
                       may include experimental bits
 rv-server-ref-v1.0 -- versioning ensures the implementation matches v1.0
                       of the spec
 rv-server-ref-v2.0 -- versioning ensures the implementation matches v2.0
                       of the spec - likely backward compatible with v1.0,
		       but not necessarily

I'm not sure if [ab]using the QEMU machine versioning support in this way
would cause confusion or other problems though.

Thanks,
drew

