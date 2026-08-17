Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5796C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvogc-0003IB-3G; Mon, 17 Aug 2026 00:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wvogD-00030x-A4
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:10:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wvogA-00016Q-US
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:10:33 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLEoZ23309446
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0p9m3jynWpUgGRsUzwX58mOLKhDIJHjO2SWOuLGoOB4=; b=Y0TaQXZTWcLT417N
 YrjD3C0Vgo79JmDaaRdJ7x896i7qHzKwukJ/kOWu2d6ZUVfWEzb6h34tSQBPaWYF
 O+krNOkyoon72xk1f3lS7bZFS9HlsxDH7WzQPDVIXsTJGDsUreNgqpgU0aTyTcDX
 Z9WkJFBsr9H4dnXcXdipT2KpJr7owbWmZmxhO7fSq1SbbWpeDMKzxpWdhUZYd9w2
 RGYGHnxBciX2KVvwUH0OtrWSc4C1QOvqkLwHTYXkHBnDSB9rmPpdeNTUNjr23C+z
 R78FTlbRpJJfKFsfCgpuiaDzoHN9CaIi6zRT8jqDrMEXx0jXlCLvpoqVD6mUmxmZ
 XXtD6A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq54dp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:10:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e695a3b28so401872785a.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 21:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786939828; x=1787544628; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0p9m3jynWpUgGRsUzwX58mOLKhDIJHjO2SWOuLGoOB4=;
 b=CJ1C/x0otvDiYTiT6kIwKBUj2ztDaMfxqrdOI6Xdi610OJMeJcG/YhTGPoqHQZzfJn
 mLeOGnIEvyG4SuVpXqkB3io+pGrWwqsgnnAOZIVFqyBYDnGhS9ZnuwlWJ1G49I2Qlb5o
 yjEPXaxSV+wD1t2qA63hzx4p2QlIyc5sm+IiB8eogpOyifUV6ShTwz8qfSckFSJqQzgx
 5XPG3IJ4ZOF/VxF+ivjGi20EydwYDbE5YT52Xk24W8NA81IN9ZcHjRGAHUFc0/y8ciTX
 nfCPXJG9f5V662iIp4gIrSzhQyPQCjwz1tkgAAKahBRhCv3lNNuZsAHDhJvAuU6Dmuto
 N0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786939828; x=1787544628;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0p9m3jynWpUgGRsUzwX58mOLKhDIJHjO2SWOuLGoOB4=;
 b=QqsP6mETStStxmELaB8lL5L3S+vX/viUKhQVwvvSnVBihCZxcLFFSLGbYW47eNQlnb
 Ep6ab+wPd8QbuGs/lkVvsAMqnnoatBEJ3XN4FD+wX/72hoVWQi12IAAUjPxv/1NaZHHF
 fJbhdlcaiGNiMoIKG/N2nbhPD35bUIXHf0gKnjHEicsbFoJzV0T/G9egshpxQPXxCA8z
 ZW3p0u+o4QKs6Heo8ceZ9Uc1WcgJmLta2L5ul2JLrofOpILVNhZxemdydvNXIQl6Js+C
 ut26wOf+lQdDuTB9ke/lQe0Xe4UGDw3lC9S5ZsBA3eX4ij4sTpscm4W82aG8XhPxyaUk
 S0fw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZnsV/F4HbtR7afQnrosDxLWUwKBXXP4spVXDfhVpmJktByzPFLk3mCs4STxA4Uv0kmDT5d5O1eTnn@nongnu.org
X-Gm-Message-State: AOJu0Ywp7TgzZwB5fFUpThe1SmuUcymToBVEguPUfqsSxFoAg0UejQtW
 7rhoZezCIve9bjreCQWOc/H4NSaVrrScDbfRr0LNqw3tJCLN0UD75yhAKjfqc7AYqF2TM2Qb6Ez
 WuOuCfUDZKbYA9/nrAenMHKN6mdkNsc2WIHYO25c/Bgw7qexxmseC46zuxA==
X-Gm-Gg: AR+sD13t5+HeOfoSsL93nso7deirzwqrZJS3FbhqvezXXuJuHwO79OO8QFM5PzGwJs+
 +9/CbfTzZucsEOdVdLmyr2WJnmv7wJaU1+9BdT33Ea4tMQy7FmG91VJn/5NFfP14RFe+qvebxNc
 hG9CsUuLyNCs7KY5b3xtJ2JpifMvQy+d2PqLs+WFRGrSmaYN5Utgchmd3oBL4rlhic8Rm2qOfJe
 pWdtr2Ad5P1LK6TPOG03ct8mEQwomV1otgow5BkQm1AOtrCafo3xJChw/FbybbmwD9TqrQE1pZX
 01a7aSNgA+aEHOSm9e1jLh2ABil5nlP+BzvxHdUruzdqYDWKfquMVvW+ClNMVjbRRlmidMRdUB3
 eWy5RoE6sCRXRmzF15iHVK9J1YnbqKEVhDWJFzTI9oBFj0doGsaTl6MEuoil8ORcfQF/5bDqldO
 7qrSKZ
X-Received: by 2002:a05:620a:8c8b:b0:92e:650f:c392 with SMTP id
 af79cd13be357-936cffade97mr1467455285a.17.1786939827709; 
 Sun, 16 Aug 2026 21:10:27 -0700 (PDT)
X-Received: by 2002:a05:620a:8c8b:b0:92e:650f:c392 with SMTP id
 af79cd13be357-936cffade97mr1467453085a.17.1786939827245; 
 Sun, 16 Aug 2026 21:10:27 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce1f535fsm909991485a.23.2026.08.16.21.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 21:10:26 -0700 (PDT)
Message-ID: <0c2df8f1-8c50-4733-b38a-8ec1366f1691@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 23:10:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] target/hexagon: add main arch-specific
 semihosting operations
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
 <96776c988e48b04a59a146fb62a934389a73a4a2.1784568922.git.matheus.bernardino@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <96776c988e48b04a59a146fb62a934389a73a4a2.1784568922.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyOSBTYWx0ZWRfXzvXtrtIoGHXU
 ATlKA8tT0+GO+5LEpaOds5xfsTR4ww5nktLcxz6tO4SHXn3IE7rE4tH6vZpa1CQgrZzMBOhBvnO
 Dg00Oex9G+KrvQ5Oc7/GYG1MLC5I7cpp8FNiE5ugbY0FQnWw9uZUjpV2Sj+bXWGou4ckP3EnCr3
 OhCdk+6D6cfh3UhYST0EOwxc1VTGXQJIcDHV24BbFSU9+itAYzlHnpyPvK3tkLEq+6p5E5rUox3
 q/2ODw3mNAzJHlHS+j17RbIfeF4cl8E/5U6TyWwoQxrescmPoAg+ojHpHU1voX4f8H961UsugvX
 pWWlR+aIg6px4Q5cyPOWKt+kFy17m0CFJTCMU5CkkLTzLR4XgCi/QhbZCB/Pd1No5uLZwkisOlj
 MhHnHycnvmrLu+DnCAfk++SrcUrtAxDuXTZ4Qf9ukvHr+FD64MVJtXrgASMu5HVeNuiXqPwWCOn
 cwZzjeJKb4B9yqmqAGQ==
X-Proofpoint-ORIG-GUID: Jxiid8Ff4DYE0tnSfktJhvQWBTVFZkf_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyOSBTYWx0ZWRfX52MucUWrxXJy
 ReP7lYngAGwMTnXMkE97DVEvNJWsbkFHSO+5Hg4Wn8YkabxoceP0Jlo85kMLYej9qicDS+Nob+L
 Kjw3qIr0ZpF1lNZtPzqjvHW57C8qWVI=
X-Proofpoint-GUID: Jxiid8Ff4DYE0tnSfktJhvQWBTVFZkf_
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a8289b4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=GDmYP6drKu5ZF-RL0lsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170029
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


On 7/20/2026 12:41 PM, Matheus Tavares Bernardino wrote:
> The Hexagon semihosting ABI extends the arm-compatible set with
> operations like OPEN, WRITECREG, WRITE0, ISTTY, STAT, FSTAT, FTELL,
> SEEK, FTRUNC, ACCESS, and GETCWD. Implement these trap0 handlers so
> that baremetal programs using the standard Hexagon simulator ABI can
> perform file I/O when running on qemu-system-hexagon.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

With the changes to omit arch_{sg}et_system_reg():

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> ---
>   include/semihosting/common-semi.h |   1 +
>   semihosting/arm-compat-semi.c     |   2 +-
>   target/hexagon/hexswi.c           | 298 +++++++++++++++++++++++++++++-
>   3 files changed, 299 insertions(+), 2 deletions(-)
>
> diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
> index a11905ef4ef..1e7699d7bbd 100644
> --- a/include/semihosting/common-semi.h
> +++ b/include/semihosting/common-semi.h
> @@ -34,6 +34,7 @@
>   #ifndef COMMON_SEMI_H
>   #define COMMON_SEMI_H
>   
> +void common_semi_cb(CPUState *cs, uint64_t ret, int err);
>   void do_common_semihosting(CPUState *cs);
>   uint64_t common_semi_arg(CPUState *cs, int argno);
>   void common_semi_set_ret(CPUState *cs, uint64_t ret);
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index c54753f696f..b930a028649 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -229,7 +229,7 @@ static inline uint32_t get_swi_errno(CPUState *cs)
>   #endif
>   }
>   
> -static void common_semi_cb(CPUState *cs, uint64_t ret, int err)
> +void common_semi_cb(CPUState *cs, uint64_t ret, int err)
>   {
>       if (err) {
>   #ifdef CONFIG_USER_ONLY
> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> index 2aedd8368e2..6efc00fedf9 100644
> --- a/target/hexagon/hexswi.c
> +++ b/target/hexagon/hexswi.c
> @@ -85,6 +85,41 @@ static inline bool is_hexagon_specific_swi_flag(enum hex_swi_flag what_swi)
>   }
>   #undef DEF_SWI_FLAG
>   
> +static const unsigned int angel_to_host_filemode_table[] = {
> +    O_RDONLY,
> +    O_RDONLY | O_BINARY,
> +    O_RDWR,
> +    O_RDWR | O_BINARY,
> +    O_WRONLY | O_CREAT | O_TRUNC,
> +    O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
> +    O_RDWR | O_CREAT | O_TRUNC,
> +    O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
> +    O_WRONLY | O_APPEND | O_CREAT,
> +    O_WRONLY | O_APPEND | O_CREAT | O_BINARY,
> +    O_RDWR | O_APPEND | O_CREAT,
> +    O_RDWR | O_APPEND | O_CREAT | O_BINARY,
> +    O_RDWR | O_CREAT,
> +    O_RDWR | O_CREAT | O_EXCL
> +};
> +
> +/*
> + * This must match the caller's definition, it would be in the
> + * caller's angel.h or equivalent header.
> + */
> +struct __SYS_STAT {
> +    uint64_t dev;
> +    uint64_t ino;
> +    uint32_t mode;
> +    uint32_t nlink;
> +    uint64_t rdev;
> +    uint32_t size;
> +    uint32_t __pad1;
> +    uint32_t atime;
> +    uint32_t mtime;
> +    uint32_t ctime;
> +    uint32_t __pad2;
> +} sys_stat;
> +
>   static void init_semihosting_guestfds(void)
>   {
>       static gsize initialized;
> @@ -119,10 +154,19 @@ static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
>       hexagon_peek_memory_range(env, addr, count, retaddr);
>   }
>   
> +static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
> +{
> +    if (err) {
> +        ret = -1;
> +    }
> +    common_semi_cb(cs, ret, err);
> +}
> +
>   static void sim_handle_trap0(CPUHexagonState *env)
>   {
>       target_ulong what_swi, swi_info;
>       CPUState *cs = env_cpu(env);
> +    uintptr_t retaddr = 0;
>   
>       g_assert(bql_locked());
>       init_semihosting_guestfds();
> @@ -177,7 +221,259 @@ static void sim_handle_trap0(CPUHexagonState *env)
>       }
>       break;
>   
> -    /* TODO: implement other hexagon-specific semihosting calls */
> +    case HEX_SYS_OPEN:
> +    {
> +        char filename[BUFSIZ];
> +        target_ulong physical_filename_addr;
> +        unsigned int filemode;
> +        int length;
> +        int real_openmode;
> +        int ret, err = 0;
> +        int i = 0;
> +
> +        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
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
> +            hexagon_read_memory(env, physical_filename_addr + i, 1, &filename[i],
> +                                retaddr);
> +            i++;
> +        } while (filename[i - 1]);
> +
> +        /* convert ARM ANGEL filemode into host filemode */
> +        if (filemode < ARRAY_SIZE(angel_to_host_filemode_table)) {
> +            real_openmode = angel_to_host_filemode_table[filemode];
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
> +     * on error, neither errno. So we override with our own implementation.
> +     */
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
> +        struct stat st_buf;
> +        uint8_t *st_bufptr = (uint8_t *)&sys_stat;
> +        int rc, err = 0;
> +        char filename[BUFSIZ];
> +        target_ulong physical_filename_addr;
> +        target_ulong statBufferAddr;
> +        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
> +
> +        if (what_swi == HEX_SYS_STAT) {
> +            int i = 0;
> +            do {
> +                hexagon_read_memory(env, physical_filename_addr + i, 1,
> +                                    &filename[i], retaddr);
> +                i++;
> +            } while ((i < BUFSIZ) && filename[i - 1]);
> +            rc = stat(filename, &st_buf);
> +            err = errno;
> +        } else {
> +            int fd = physical_filename_addr;
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
> +#if defined(__linux__)
> +            sys_stat.atime = (uint32_t) st_buf.st_atim.tv_sec;
> +            sys_stat.mtime = (uint32_t) st_buf.st_mtim.tv_sec;
> +            sys_stat.ctime = (uint32_t) st_buf.st_ctim.tv_sec;
> +#elif defined(_WIN32)
> +            sys_stat.atime = st_buf.st_atime;
> +            sys_stat.mtime = st_buf.st_mtime;
> +            sys_stat.ctime = st_buf.st_ctime;
> +#endif
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
>   
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR,

