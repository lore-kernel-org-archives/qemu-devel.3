Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB170C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjP0y-0003Ci-9H; Mon, 13 Jul 2026 18:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjP0v-0003CK-OY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:20:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjP0t-0008Rg-As
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:20:37 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9ZDD2356054
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DCqfm2mlE34Igml2czZvy51Z/0y4p0ZuqUnrDiVsUCs=; b=Px64GHuwHqVqSuLN
 +iV51dIeI7eoqIlhYogC/ppqoOXHVbSW/mBTwFYEWb4ZADhNJpuTUd9EqhRaWwfn
 6o9d30hhSaAA1HnAgfRs2GTFp6K2vzCkar+StAU8qsKDvY1z/YPkv07JvaoPjOxx
 CfEFLOiEgesIlEC7ja1jPprT9/LSqSZRtAo65WrCbcoo21anvKQ6aojUR2Qsbbqp
 STQund7/Rb4TdJEWq5dMKSPEDbTrurIGGU96n3KgJynChjvBlstAHeAHb96O4APZ
 fITUju7koDAuFoHvafW+IB+Q159CiDn03turI38HpwZmnWtri7kxhPfja2twuvz9
 6UeJgw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4tqhh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:20:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c860544c077so625573a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783981232; x=1784586032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DCqfm2mlE34Igml2czZvy51Z/0y4p0ZuqUnrDiVsUCs=;
 b=ZTlXYYoXOFy5JNYNDAlGN9Jxy4hNtFflmpOsIwC4CFK46Yj1tZnUp6V18v7xpGLfmS
 mROlc5N8ekYA37g1DuDH5ATong7U2KctwSdo+c2l/t7Hvj9eC4Tg6Z95Jwd2QM3IHl9d
 G0ojckWESENWGiuCgRaEPtZMI7jpyscvQDuKe9E+yIlvwKAzrfp6spgyjZ9Y+naEgZ5Z
 7/NPpcgDEvnGXcWpUdUCZfm2PuBC3lOo11DgZ8AtXyzH0R9Wb+w4tKdJS31k8Lou/eoX
 eofHBUE5KGGkEvOCiVBrRfUwX9btfWo8aqtPCBCtMbW0lmqvav/a7lzaARILEGm5DMXj
 g0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783981232; x=1784586032;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DCqfm2mlE34Igml2czZvy51Z/0y4p0ZuqUnrDiVsUCs=;
 b=stR+8EsIiuMM0xdfAl1mYWzYsealj3u1wEpQB+UCuWgpHaJCwxe8kz+vYVMjW7XwG2
 BeMNFHsLqESSg1kDkyhjBMVzRwqvDvyputtJ6Ch/GwB9tZshgk4oysmXdv4onAl7ztUp
 jyNkq/LFtkYhAGh/pu4G44EDHr4XA0z9G8sTTSDHUX6mguPzoY3hKVvJglH56CCB+Cis
 TVOG4PcZUVdvMu2nX57sW8klKOnCd5mndRCkUhUsSJMARmAbW4JInZHydM8lenGsNLbh
 GFpTHP2HR0ErmVF9b0mnaKwEM3CxNontBDOixSyLj5QnduhEeIZxSyqZj5WftYe5HaGg
 JrJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzIsNLyk8PSHjrS95KsA+3fbxJ4kyMKzKSqJJvIaQHrM3kYd6O3c5A5EM6vFpo6L/LJ80hh1/ThSrd@nongnu.org
X-Gm-Message-State: AOJu0Yz74hPKgETrmJDqE6t8xBhQ3cugwAzJLUD0ewJzvNYGgcpshCyn
 CVC63eSctbdcaphxWqcdq++1vNEYf53ijeLrzPnnTFnVqos2DfHt9D/NA7RXSQYKfJAsWChj/bt
 rDO05/Jehaot9w8VQtdQvKNdtNghwUfuIntXHBIK3t8s0Qjfi11H3jvlshA==
X-Gm-Gg: AfdE7cnniPTmo8i7K5mOmLzKJSFjHBZ8sBqG+8xbprtHh6SU2gCDyDFh4qvQ5GoP5w4
 J5jX4LefS2LDgsKVol2Bpv8shIaJlDD3UvBG5Gu1kfKXm6eb7j43Cu8OndYEAyGjTL9CvSeYJQw
 Zs01xX1/D+zfZWARpYv1AIp68hJePdVm3c3S1SSc7JoTTq2v9WM5rL0UIFTHt6EJlK+35w28n66
 yHWHw9z7nprDQG77R7r3hpEoM96ByehU7H2ZiUtVDarnrpPfw5CSSlm++7IBVYvpLL/KA1wvDHV
 zToC8j5nesNZzYBl8cA7bSO/M+XSy5Dl+b5YSe6px3EAAwCBpW7Sge/Z4jGYG8o3XGdKIh4C0/L
 LFPo+0K/PsNKMOcT0BUgW2K6xXb5SKX3vhnmIEEmRfRzMHzQrnbZCPz34Sozb0CslKj9DWg9gaN
 u8WbY=
X-Received: by 2002:a05:6a21:389:b0:3bf:95f4:dad7 with SMTP id
 adf61e73a8af0-3c11077486dmr10913403637.41.1783981232170; 
 Mon, 13 Jul 2026 15:20:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:389:b0:3bf:95f4:dad7 with SMTP id
 adf61e73a8af0-3c11077486dmr10913376637.41.1783981231705; 
 Mon, 13 Jul 2026 15:20:31 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483dec6sm75320461eec.11.2026.07.13.15.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 15:20:30 -0700 (PDT)
Message-ID: <16868af0-8114-4f0f-81b8-05d6e6637e8f@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:20:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] target/hexagon: add main arch-specific semihosting
 operations
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <45fc870a747a670c26906d18909bc31fe816bd22.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <45fc870a747a670c26906d18909bc31fe816bd22.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a5564b1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=GDmYP6drKu5ZF-RL0lsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyOSBTYWx0ZWRfXxB+0mlW2CC2U
 ftmomC5OcsqQOSoRsPUU5T90dwsRK0O4yr61LwWOu5lEhPuDyezSSvy/QorhuPp6IRGJCgpXbEL
 UGnZEoKqVVceAsL1uI9QxbA01Wy6D4E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyOSBTYWx0ZWRfX6dd+6HxfF6oL
 WtctygNhuzlwByhymbVSSbToObSoQpT20Xi7AHXwre1mIYFkJguqrHPJyZGtrYPgQAzbXj1PVh2
 NFqfdT36r3226HpH91zFUNdpg+0z/k9SxgVvBQqK40067ixvVa8qpJ2wfP1trg/qXPSE12Kdllk
 GAHYVuGQNdZRZB8X1iW7WCpLTWP3FI09HrchHlDjMmDphpFxQIZo6v/ixDYwYl5v+aMLhzHq+aH
 vHMYHPVqb+QHwb+xC2yHwxizhhAKDcUtr13Iodwlrta8wxxJcR6IMSZLcOtKMq/mWMFnWUtvLHl
 Dz2kcqKzJDYXvtXHLH1ry7d7Ag/xxueFrhxaBTMs90YHsxd7OtOVt/ZZBjP4n0HUIg3NWj7Ej9X
 ZOYbTgAmOxzH/DYmiK9WksEJz2cNjFdK8RdkA22yHKJOWUQHV63veYd1NBb/kf6OkI6UUlmyRkE
 3yJYZ1ZrnnPtofOOPGQ==
X-Proofpoint-ORIG-GUID: E0kBsUJjvOeh-bg25So3jNy-08SG9Rbu
X-Proofpoint-GUID: E0kBsUJjvOeh-bg25So3jNy-08SG9Rbu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130229
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> The Hexagon semihosting ABI extends the arm-compatible set with
> operations like OPEN, WRITECREG, WRITE0, ISTTY, STAT, FSTAT, FTELL,
> SEEK, FTRUNC, ACCESS, and GETCWD. Implement these trap0 handlers so
> that baremetal programs using the standard Hexagon simulator ABI can
> perform file I/O when running on qemu-system-hexagon.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/semihosting/common-semi.h |   1 +
>  semihosting/arm-compat-semi.c     |   2 +-
>  target/hexagon/hexswi.c           | 293 +++++++++++++++++++++++++++++-
>  3 files changed, 294 insertions(+), 2 deletions(-)
> 
> diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
> index a11905ef4ef..1e7699d7bbd 100644
> --- a/include/semihosting/common-semi.h
> +++ b/include/semihosting/common-semi.h
> @@ -34,6 +34,7 @@
>  #ifndef COMMON_SEMI_H
>  #define COMMON_SEMI_H
>  
> +void common_semi_cb(CPUState *cs, uint64_t ret, int err);
>  void do_common_semihosting(CPUState *cs);
>  uint64_t common_semi_arg(CPUState *cs, int argno);
>  void common_semi_set_ret(CPUState *cs, uint64_t ret);
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index c54753f696f..b930a028649 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -229,7 +229,7 @@ static inline uint32_t get_swi_errno(CPUState *cs)
>  #endif
>  }
>  
> -static void common_semi_cb(CPUState *cs, uint64_t ret, int err)
> +void common_semi_cb(CPUState *cs, uint64_t ret, int err)
>  {
>      if (err) {
>  #ifdef CONFIG_USER_ONLY
> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> index ce9c85ad6aa..2c60e4d9e9f 100644
> --- a/target/hexagon/hexswi.c
> +++ b/target/hexagon/hexswi.c
> @@ -119,6 +119,14 @@ static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
>      hexagon_touch_memory(env, addr, count, retaddr);
>  }
>  
> +static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
> +{
> +    if (err) {
> +        ret = -1;
> +    }
> +    common_semi_cb(cs, ret, err);
> +}
> +
>  static void sim_handle_trap0(CPUHexagonState *env)
>  {
>      target_ulong what_swi, swi_info;
> @@ -174,7 +182,290 @@ static void sim_handle_trap0(CPUHexagonState *env)
>          qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>          break;
>  
> -    /* TODO: implement other hexagon-specific semihosting calls */
> +#ifndef _WIN32
> +    case HEX_SYS_OPEN:
> +    {
> +        char filename[BUFSIZ];
> +        target_ulong physicalFilenameAddr;

style: physical_filename_addr;

> +        unsigned int filemode;
> +        int length;
> +        int real_openmode;
> +        int ret, err = 0;
> +        int i = 0;
> +        static const unsigned int mode_table[] = {
> +            O_RDONLY,
> +            O_RDONLY | O_BINARY,
> +            O_RDWR,
> +            O_RDWR | O_BINARY,
> +            O_WRONLY | O_CREAT | O_TRUNC,
> +            O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
> +            O_RDWR | O_CREAT | O_TRUNC,
> +            O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
> +            O_WRONLY | O_APPEND | O_CREAT,
> +            O_WRONLY | O_APPEND | O_CREAT | O_BINARY,
> +            O_RDWR | O_APPEND | O_CREAT,
> +            O_RDWR | O_APPEND | O_CREAT | O_BINARY,
> +            O_RDWR | O_CREAT,
> +            O_RDWR | O_CREAT | O_EXCL
> +        };
> +

Better to extract this with a static const, and a useful name.
angel_to_host_filemode_table.

> +
> +        hexagon_read_memory(env, swi_info, 4, &physicalFilenameAddr, retaddr);
> +        hexagon_read_memory(env, swi_info + 4, 4, &filemode, retaddr);
> +        hexagon_read_memory(env, swi_info + 8, 4, &length, retaddr);
> +
> +        if (length >= BUFSIZ) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: filename too large (%d)\n",
> +                          __func__, length);
> +            common_semi_cb(cs, -1, ENAMETOOLONG);
> +            break;
> +        }
> +
> +        do {
> +            hexagon_read_memory(env, physicalFilenameAddr + i, 1, &filename[i],
> +                                retaddr);
> +            i++;
> +        } while (filename[i - 1]);
> +
> +        /* convert ARM ANGEL filemode into host filemode */
> +        if (filemode < 14) {

Also, compare to sizeof table introduced, or define a constant.
ANGEL_FILEMODE_MAX = 13.

> +            real_openmode = mode_table[filemode];
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: invalid OPEN mode: %u\n",
> +                          __func__, filemode);
> +            common_semi_cb(cs, -1, EINVAL);
> +            break;
> +        }
> +
> +        if (strcmp(filename, ":tt") == 0 &&
> +            qemu_semihosting_console_has_chardev()) {
> +            ret = alloc_guestfd();
> +            console_guestfd(ret);
> +        } else {
> +            ret = open(filename, real_openmode | O_BINARY, 0644);
> +
> +            if (ret == -1) {
> +                err = errno;
> +            } else {
> +                int guestfd = alloc_guestfd();
> +                associate_guestfd(guestfd, ret);
> +                ret = guestfd;
> +            }
> +        }
> +        common_semi_cb(cs, ret, err);
> +    }
> +    break;
> +
> +    case HEX_SYS_WRITECREG:
> +    {
> +        char c = swi_info;
> +        qemu_semihosting_console_write(&c, 1);
> +    }
> +    break;
> +
> +    /*
> +     * Hexagon's SYS_ISTTY is a bit different than arm's: we do not return -1
> +     * on error, neither errno. So we override with out own implementation.
> +     */

s/out/our

> +    case HEX_SYS_ISTTY:
> +    {
> +        int fd;
> +        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
> +        common_semi_cb(cs, isatty(fd), 0);
> +    }
> +    break;
> +
> +    case HEX_SYS_SEEK:
> +    {
> +        int fd;
> +        target_ulong off;
> +        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
> +        hexagon_read_memory(env, swi_info + 4, 4, &off, retaddr);
> +        semihost_sys_lseek(env_cpu(env), common_semi_ftell_cb, fd, off,
> +                          GDB_SEEK_SET);
> +    }
> +    break;
> +
> +    case HEX_SYS_STAT:
> +    case HEX_SYS_FSTAT:
> +    {
> +        /*
> +         * This must match the caller's definition, it would be in the
> +         * caller's angel.h or equivalent header.
> +         */

It would be great to move this definition out of this function also.

> +        struct __SYS_STAT {
> +            uint64_t dev;
> +            uint64_t ino;
> +            uint32_t mode;
> +            uint32_t nlink;
> +            uint64_t rdev;
> +            uint32_t size;
> +            uint32_t __pad1;
> +            uint32_t atime;
> +            uint32_t mtime;
> +            uint32_t ctime;
> +            uint32_t __pad2;
> +        } sys_stat;
> +        struct stat st_buf;
> +        uint8_t *st_bufptr = (uint8_t *)&sys_stat;
> +        int rc, err = 0;
> +        char filename[BUFSIZ];
> +        target_ulong physicalFilenameAddr;
> +        target_ulong statBufferAddr;
> +        hexagon_read_memory(env, swi_info, 4, &physicalFilenameAddr, retaddr);
> +
> +        if (what_swi == HEX_SYS_STAT) {
> +            int i = 0;
> +            do {
> +                hexagon_read_memory(env, physicalFilenameAddr + i, 1,
> +                                    &filename[i], retaddr);
> +                i++;
> +            } while ((i < BUFSIZ) && filename[i - 1]);
> +            rc = stat(filename, &st_buf);
> +            err = errno;
> +        } else {
> +            int fd = physicalFilenameAddr;
> +            GuestFD *gf = get_guestfd(fd);
> +            if (!gf || gf->type != GuestFDHost) {
> +                qemu_log_mask(LOG_UNIMP,
> +                              "fstat semihosting only implemented"
> +                              " for native mode\n");
> +                g_assert_not_reached();
> +            }
> +            rc = fstat(gf->hostfd, &st_buf);
> +            err = errno;
> +        }
> +        if (rc == 0) {
> +            sys_stat.dev   = st_buf.st_dev;
> +            sys_stat.ino   = st_buf.st_ino;
> +            sys_stat.mode  = st_buf.st_mode;
> +            sys_stat.nlink = (uint32_t) st_buf.st_nlink;
> +            sys_stat.rdev  = st_buf.st_rdev;
> +            sys_stat.size  = (uint32_t) st_buf.st_size;
> +            sys_stat.atime = (uint32_t) st_buf.st_atim.tv_sec;
> +            sys_stat.mtime = (uint32_t) st_buf.st_mtim.tv_sec;
> +            sys_stat.ctime = (uint32_t) st_buf.st_ctim.tv_sec;
> +        }
> +        hexagon_read_memory(env, swi_info + 4, 4, &statBufferAddr, retaddr);
> +
> +        for (int i = 0; i < sizeof(sys_stat); i++) {
> +            hexagon_write_memory(env, statBufferAddr + i, 1, st_bufptr[i],
> +                                 retaddr);
> +        }
> +        common_semi_cb(cs, rc, rc == 0 ? 0 : err);
> +    }
> +    break;
> +
> +    case HEX_SYS_FTRUNC:
> +    {
> +        int fd;
> +        off_t size_limit;
> +        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
> +        hexagon_read_memory(env, swi_info + 4, 8, &size_limit, retaddr);
> +        semihost_sys_ftruncate(cs, common_semi_cb, fd, size_limit);
> +    }
> +    break;
> +
> +    case HEX_SYS_ACCESS:
> +    {
> +        char filename[BUFSIZ];
> +        uint32_t FileNameAddr;
> +        uint32_t BufferMode;
> +        int rc;
> +
> +        int i = 0;
> +
> +        hexagon_read_memory(env, swi_info, 4, &FileNameAddr, retaddr);
> +        do {
> +            hexagon_read_memory(env, FileNameAddr + i, 1, &filename[i],
> +                                retaddr);
> +            i++;
> +        } while ((i < BUFSIZ) && (filename[i - 1]));
> +        filename[i] = 0;
> +
> +        hexagon_read_memory(env, swi_info + 4, 4, &BufferMode, retaddr);
> +
> +        rc = access(filename, BufferMode);
> +        common_semi_cb(cs, rc,  rc == 0 ? 0 : errno);
> +    }
> +    break;
> +
> +    case HEX_SYS_GETCWD:
> +    {
> +        char cwdPtr[PATH_MAX];
> +        uint32_t BufferAddr;
> +        uint32_t BufferSize;
> +        uint32_t rc = 0, err = 0;
> +
> +        hexagon_read_memory(env, swi_info, 4, &BufferAddr, retaddr);
> +        hexagon_read_memory(env, swi_info + 4, 4, &BufferSize, retaddr);
> +
> +        if (!getcwd(cwdPtr, PATH_MAX)) {
> +            err = errno;
> +        } else {
> +            size_t cwd_size = strlen(cwdPtr);
> +            if (cwd_size > BufferSize) {
> +                err = ERANGE;
> +            } else {
> +                for (int i = 0; i < cwd_size; i++) {
> +                    hexagon_write_memory(env, BufferAddr + i, 1,
> +                                         (uint64_t)cwdPtr[i], retaddr);
> +                }
> +                rc = BufferAddr;
> +            }
> +        }
> +        common_semi_cb(cs, rc, rc != 0 ? 0 : err);
> +        break;
> +    }
> +
> +    case HEX_SYS_EXEC:
> +    {
> +        qemu_log_mask(LOG_UNIMP, "SYS_EXEC is deprecated\n");
> +        common_semi_cb(cs, -1, ENOSYS);
> +    }
> +    break;
> +
> +    case HEX_SYS_FTELL:
> +    {
> +        int fd;
> +        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
> +        semihost_sys_lseek(cs, common_semi_ftell_cb, fd, 0, GDB_SEEK_CUR);
> +    }
> +    break;
> +
> +    case HEX_SYS_READ_CYCLES:
> +    case HEX_SYS_READ_TCYCLES:
> +    case HEX_SYS_READ_ICOUNT:
> +    {
> +        arch_set_thread_reg(env, HEX_REG_R00, 0);
> +        arch_set_thread_reg(env, HEX_REG_R01, 0);
> +        break;
> +    }
> +
> +    case HEX_SYS_READ_PCYCLES:
> +    {
> +        arch_set_thread_reg(env, HEX_REG_R00,
> +            arch_get_system_reg(env, HEX_SREG_PCYCLELO));
> +        arch_set_thread_reg(env, HEX_REG_R01,
> +            arch_get_system_reg(env, HEX_SREG_PCYCLEHI));
> +        break;
> +    }
> +
> +    case HEX_SYS_PROF_ON:
> +    case HEX_SYS_PROF_OFF:
> +    case HEX_SYS_PROF_STATSRESET:
> +    case HEX_SYS_DUMP_PMU_STATS:
> +    case HEX_SYS_HEAPINFO:
> +        common_semi_cb(cs, -1, ENOSYS);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "SWI call %" PRIx32
> +                      " is unimplemented in QEMU\n",
> +                      (uint32_t)what_swi);
> +        break;
> +
> +#endif /* ! _WIN32 */
>  
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,


