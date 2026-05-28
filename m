Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E253ACD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSg4v-00014s-UE; Thu, 28 May 2026 15:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSg4u-00014e-4u
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:07:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSg4s-0002dY-5x
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:07:35 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SI52xA124483
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q2uYoAEIj2gLazoOOuy/z0BxtNib/RdfgM5ehVCW/Jw=; b=oR00ZpTpPdk8n3vO
 nymVqHWK+FE31l7kmpNBGBDrFB8dF0qzu6si7Ynun4ptxbmPHtUXZuaZol0gDfWT
 wpP32lUC7x0QSKMDyoQJfGbK9pOl0gIGc+dv27+jKjKhZedTIZ0cn+k4GoZ6sUoP
 jNBL8GpjOK/gdDV/NdTsBSWWrhOBridrcrosf0ghXgAOdLqCGOPYmsMrEGaiSJ2p
 rrH2Q8I/BQ2hymlJ36qkRs/+yrYNB737XmJNvK0XKCJdd/7hyDCAeyfITFZxCUaI
 wwA9WNx79XBL5cPTGFS49ZBQUIDZu7HvDseKJ+MZmvn0z1MoQOPdqwsnuQPdo9Bh
 tuTpOA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yccadk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:07:32 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13536592ebeso414480c88.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779995251; x=1780600051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q2uYoAEIj2gLazoOOuy/z0BxtNib/RdfgM5ehVCW/Jw=;
 b=YxAPqL3A6HA8kd4POj0f1Di12rfBE1m3sl+y0Vnr6Bpl2p5Nhg0JUnzsdoOoa3j58N
 9qhmR3U3kYXPTcqyn5asJ9KFFXhYs2bY/aNvayny5Hkad5zwT6Bq0wdc4GMbmvDNlNFe
 MixAmzMCmTGA49dtBvFAGTBmR8BXw9CwJuxBK5bkGqKN05QAIJAU4hpuM5VapJ8zuVvx
 YW9/VXDo3ywXfK+Aw5MBngVz0gFvNPlUdD1THZmvS2eDsxzHDJPG6gGIAZUGP6iSVX0U
 5incnm+YKZC9NL/Meeq//psYS3R7f18CKSshDtm2FH0AaGPyNLJda/1DHbugTzEBBbH8
 gt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779995251; x=1780600051;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q2uYoAEIj2gLazoOOuy/z0BxtNib/RdfgM5ehVCW/Jw=;
 b=LQrLO2cB+M627A2BgkJB4D69xvLhUaBnehED1ABk4BGXChm+Ro6OChFuYv2LrOx9u4
 x3boHf/2QEFphq7ilRLpfLm6LbNTWPBo+7ewdn3gj30uWEayPCyM6G4mhgT2EqaOnRIH
 nohSTE0Z69rEq9eke+DWIZB3Oy7LaVH3qRYWTthn5LmzWs7KboJVFwGDX1D1Uv6XiF0k
 qX2ICoHCTgbVydsU99dSBaYsJRNfLpO7lGBsyiA7CjfmEhLga0BCQ/KVtGUf5ABLJXcd
 7aQyfoRyqWa4aCRBXUy2BMFQ2j+E8mQiUYAjoGtYwGGswz+HS612cOTzue8ru9DD26e5
 r2tQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ97e7DQkzlAIcJ2UbgEizWomyuwApk5rxyOipC6cgxey8QVC2h1PHcTcspjSPQhisMtMtoHGkExNsf4@nongnu.org
X-Gm-Message-State: AOJu0YzfqiSqUUgHd4kaTls2zqz9J8zzxxjFB+W+JLwHAbXMFEl2U81G
 N1hmshNGJG4Jpx0SJYbU+8Qobbi0dE6bCGWH+dIYfmQ4CfnLA65JD6b4rgivt6WrjEzOukPtb52
 rM/ZQFeI/t+6oqRFsc1dNMUukswMXShrueubAUQDm9VirOPeYJA2dXV6hUQ==
X-Gm-Gg: Acq92OGiAhHswjMHuOnnmGLqOrziJ6ZMwSLjtyl9U+pyrKr2Ao4UgApKGbP4BoYeRAi
 7rQ7XM4n/jV8lA9qZGcL6cJ8tJG8BM2IErUCkR5hrHYfHgmiZZn/IS7FlZT9MsSG45H5IS1V0o4
 w/P4X4MmR/B45hxvnheglzAnfN3f5qneUWHF5e8GfisD6fJpTQfUpKJnL7Cp9AosZvt+nbaQPOz
 dQLz350aSFhph6RFzQYxaKci2maaRYlz8JlAqHKoRqoT/K9lz26wVjKbRNy1t5itF42jY8PvdbN
 3sQs9Ddp2WAAjsmptWJ2790fH7C5qWU95sv7xFiy7BS5t5olR2fZd2MkiI3J78m97ssvqc2VCRF
 YsQnxtj+hKVdRedd3BdeRjz4BiyxlOnbycne9su5NPbzdODgrNMbhWEqWaruq7CPx1OijUeczpz
 ZTr3CfnYjeinH01EJjSqZ1EORH
X-Received: by 2002:a05:7022:f207:b0:12f:c7c3:f5ab with SMTP id
 a92af1059eb24-137a8ae9abamr108022c88.2.1779995250984; 
 Thu, 28 May 2026 12:07:30 -0700 (PDT)
X-Received: by 2002:a05:7022:f207:b0:12f:c7c3:f5ab with SMTP id
 a92af1059eb24-137a8ae9abamr108002c88.2.1779995250408; 
 Thu, 28 May 2026 12:07:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137a9ac8405sm64732c88.12.2026.05.28.12.07.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:07:29 -0700 (PDT)
Message-ID: <77a000e4-04dd-4abe-95ac-0c411e8e0575@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:07:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] linux-user: implement fsmount(2) series of syscalls
To: Xinhui Yang <cyan@cyano.uk>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Mingcong Bai <jeffbai@aosc.io>
References: <cover.1779876076.git.cyan@cyano.uk>
 <cec3a2d387f87cd9a8b03d864c7accd804d698ce.1779876076.git.cyan@cyano.uk>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cec3a2d387f87cd9a8b03d864c7accd804d698ce.1779876076.git.cyan@cyano.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a189274 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=H-X7bUBZzkprN-Wk_aMA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: hZhgnWIZ2fOCv7JRasH8nDs9e-FzEk-1
X-Proofpoint-ORIG-GUID: hZhgnWIZ2fOCv7JRasH8nDs9e-FzEk-1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5MiBTYWx0ZWRfX/NtWl0oco3l9
 7JN+/PxrkttgVgKN9nYF34l10Dv1jtfSutWlUR2pQk35QGp7egf9UnbkV3W7uK2Y+LneNCAFtav
 OxmGYAR2Dd95fO1daP8UmZbRkPiys2hYIpmPb1au4uN+FemE+12iMvNbI64QcONNyz+BquhZeJN
 PJyWhOwSg1I6ox2IPTc0vgntlDAVCJ7jDbNUktZiIq932bcI5OBzM+Xw2s9Gj/jT7wmzYeeLoIO
 w1uPFpwEhLBio8O1ySRb2033eolhIpZa8HEx25sr1NuY0Qv7ez6cd9dcUpWfppxtXYsT2xO6Wi5
 3zAhQsYvIt4bsq6MvBNDudYBlQnaH737lAMhj14tAfSzH2eCNpvm0ofRR5YJmnpmLkF5g1KKPiJ
 /4+dd3H2rDaC+6c4YLJNlLqE7Zk+msCJtPT++aCBVk0ml5IBWjZYwkRAaTljSsqkDPisPQV5eGm
 +CZoQ8P85yFnGmGO0xQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280192
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

On 5/27/2026 3:11 AM, Xinhui Yang wrote:
> This series of syscalls replaces the old mount(2) syscall with a series
> of syscalls that operates around a filesystem context. This series of
> syscalls is available since Linux 5.2 and glibc 2.36+.
> 
> Their users include systemd since v259 and libmount from util-linux, and
> possibly other widely used projects.
> 
> Preliminary checks are implemented to ensure the validity of the
> interface.
> 
> Signed-off-by: Xinhui Yang <cyan@cyano.uk>
> ---
>  linux-user/syscall.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7d7a7b489c..2ff80f4dfa 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -14412,6 +14412,87 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>          return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
>  #endif
>  
> +#if defined(TARGET_NR_fsopen)
> +    case TARGET_NR_fsopen:
> +        {
> +            p = lock_user_string(arg1);
> +            if (!p) {
> +                return -TARGET_EFAULT;
> +            }
> +            ret = get_errno(fsopen(p, arg2));
> +            unlock_user(p, arg1, 0);
> +        }
> +        return ret;
> +    case TARGET_NR_fsconfig:
> +        {
> +            /*
> +             * fsconfig(int, int, char *, void *, int)
> +             * NOTE: p4 is nullable and its type might not be a string.
> +             */
> +            void *p3, *p4;
> +            int cmd = (int) arg2;
> +            switch (cmd) {
> +            case FSCONFIG_SET_BINARY:
> +            case FSCONFIG_SET_STRING:
> +            case FSCONFIG_SET_PATH:
> +            case FSCONFIG_SET_PATH_EMPTY:
> +                p3 = lock_user_string(arg3);
> +                if (cmd != FSCONFIG_SET_BINARY) {
> +                    /* key and value must be strings. */
> +                    p4 = lock_user_string(arg4);
> +                } else {
> +                    /* Otherise the value must be a raw buffer. */
> +                    p4 = lock_user(VERIFY_READ, arg4, arg5, 1);
> +                }
> +                if (!p3 || !p4) {
> +                    return -TARGET_EFAULT;
> +                }

Might leave with locked p3 is p4 fails.
You can add another early return just after p3 and unlock p3 in this if.

> +                ret = get_errno(fsconfig(arg1, arg2, p3, p4, arg5));
> +                unlock_user(p3, arg3, 0);
> +                unlock_user(p4, arg4, 0);
> +                break;
> +
> +            case FSCONFIG_SET_FLAG:
> +            case FSCONFIG_SET_FD:
> +                /* value must be NULL. */
> +                p3 = lock_user_string(arg3);
> +                if (!p3 || arg4) {
> +                    return -TARGET_EFAULT;
> +                }
> +                ret = get_errno(fsconfig(arg1, arg2, p3, NULL, arg5));

Similar to above (if arg4) { unlock... }

> +                unlock_user(p3, arg3, 0);
> +                break;
> +            case FSCONFIG_CMD_CREATE:
> +            case FSCONFIG_CMD_RECONFIGURE:
> +#ifdef FSCONFIG_CMD_CREATE_EXCL
> +            /*
> +             * FSCONFIG_CMD_CREATE_EXCL is only available since Linux
> +             * 6.6. Guarding it to allow building with pre-6.6 headers.
> +             */
> +            case FSCONFIG_CMD_CREATE_EXCL:
> +#endif
> +                /* key and value must be NULL, aux must be 0. */
> +                if (arg3 || arg4 || arg5) {
> +                    return -TARGET_EFAULT;
> +                }
> +                ret = get_errno(fsconfig(arg1, arg2, NULL, NULL, 0));
> +                break;
> +            default:
> +                return -TARGET_EFAULT;
> +            }
> +        }
> +        return ret;
> +    case TARGET_NR_fsmount:
> +        ret = get_errno(fsmount(arg1, arg2, arg3));
> +        return ret;
> +    case TARGET_NR_fspick:
> +        {
> +            p = lock_user_string(arg2);
> +            ret = get_errno(fspick(arg1, p, arg3));
> +            unlock_user(p, arg2, 0);
> +        }
> +        return ret;
> +#endif
>      default:
>          qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
>          return -TARGET_ENOSYS;


