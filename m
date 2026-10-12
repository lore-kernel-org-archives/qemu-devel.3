Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC8ECA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHnQ-0004lY-Jn; Mon, 12 Oct 2026 11:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGHn9-0004be-FG
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:18:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGHn6-0000Id-NV
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:18:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0amj2679915
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 15:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OW/utaitrpZCMqxFCxHCxnL4nle/O4ZqJkwIDZKxSsY=; b=LZ73CbGsju/Vyv8o
 V89h71pDvc14FTForEMhNswckb4f6PHxDX5zei5v+LsEDXoMYGpyga1d6ZREl5RY
 FhKT4iv9xr29IuxPx0UqY2kECDtABG7ZDeGe5JWc1Sw6eaH+U5ee/zt/6BOsS6r6
 70OULOJQLp4bCne+VjMWxWcO2mNBSAhSZMy0mn8QQ/LQXhxNT1pWovEgEK5ADTg0
 JQBxPffi73JLW65BD/n+rqG+Yi+WV4HdSf0dI9YJqzK+RMZI+2x7GLyPqbCBCcKf
 cRSHITVZpQiXbF1v8NGxrTe0Zp57RyJbU97ZGiYwPzXKfU/S7imI5m0pm/vNTg7Z
 NID3HA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1tkds-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 15:18:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93be1861d2dso306252085a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791818294; x=1792423094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OW/utaitrpZCMqxFCxHCxnL4nle/O4ZqJkwIDZKxSsY=;
 b=MG5q0uh9UwdXFJ7o3nws5c+HVztcaGKkO9Lg7Mj54qcCZCuD4aj57XSM6fGCn1+xkM
 /MXgHFxHFU8ANt74tSKWkhC2lVXmu/IXJcnixpjW+8Wu97Dkehl67IIZGkHejx85LLmz
 VPiWtyHItPeAa4lUa+CnHqJAljxAKoK9GXK/9rZPcRod6IFO31QO9Q9Tlf9HmlO1ofnk
 lko34Lh0HdQkI+AmmIY7U/Zqv4+VJ/w8/EUeRwTwvC4HKYSD5DSP5/OS9Li4HoPgpYXG
 g/m2BOAgOdaDPm1OwN8ACeoTT7YS66g7u9oE98vqAp7TcgnAQPDrlKjVEvq6bNasEf70
 FOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818294; x=1792423094;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OW/utaitrpZCMqxFCxHCxnL4nle/O4ZqJkwIDZKxSsY=;
 b=gPMlc4QDOhEKpXKzxxSX2Mv+hJlJzHUFbwVgInNp/ktAvPZVvBWAhz9ep5CxrCLd1V
 K1rMXDFYmRBLn+yExcSTcQ/MIfxRjZO3QE4sHBL2IEMXCjMVUwrFq0NzONsqVX8sebIK
 RkZLUVEmcX+grSJ06Q7dXLNw6NIIGLEM2YkM+LzazgMfKQOrQ9/3kMTFW7gYZhQ9CGmn
 bCxLzLmbrMQnVPbHI0Q/MirDn+boKfW0P4UVg0FvvmE0aw5FOhK/iRZ4bIKcnRNsi3Ye
 mSTqEbKNzRjT32LYdhl5Kpdn6D+K7oxbTKwy3soggnW63CUhaZR26BRVQtg6RV0koC6u
 0ZFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWx2g2/2vKn7uVWTsJ7PMXDVUMtg7Ox2aDi1MY9Nwn4OF936JbNnEYs6SvYd4gT8KsLMiNrxI1sdbv@nongnu.org
X-Gm-Message-State: AFq9FYIsHziDKcM6D0TTL6kALeCg/D7+ALBIBt/XOLFDL08fQY6oyAva
 SnlEY8VLklDP8Hi06ZzNoMQHTCPsV/x12xZtmsJ6q1aWwF/xrKpVfI5zkELkubHkqsJVraPjn9L
 cExmKU/4EXUe6tR+c97JyARs9XKlO5MSHdDHiP6iUTkqlAKwE6k37mtNFMw==
X-Gm-Gg: AYBFou1DFw3kj1h8rkMb1ICJcL7On8zFLY1kvQ3F3UFZK5zKq5jI3V6CQ3PofY1FRGx
 qqItG7274zytWS98URSItL4305vxN4u4V8APg+sPxYs3MG2vYbHktedrwTS4ZJUolPpHRW2xkOV
 HXm9qhCH0/0lnJqT4y1IPPTY43dS2UV1z3NkrwbvbcvSE6nUoShna3BphTbexGS5sGNLSDI+IkX
 iSkbpE7HWJmDo7MiWkuXWGvaQb4JyC+oEs4nhBCAfBGEUw7maDJoc6ikSOzjzBt1sR70kkRH1PN
 QhXUh5//LjAyMB7oITjA+aC1/Pou0kAYkVEQI5P19Rf3t6zMYBE4c4V4Cfc+uFqIYJr6zTwcyiG
 HqJCckRLfvevK1OnjtcE/PVlePlNkyEUa/p6kL8zAj3UGe8ANkL8DZAcoVIr2sveR
X-Received: by 2002:a05:620a:29cc:b0:93c:c162:125b with SMTP id
 af79cd13be357-93ebd259adcmr1669735785a.39.1791818294222; 
 Mon, 12 Oct 2026 08:18:14 -0700 (PDT)
X-Received: by 2002:a05:620a:29cc:b0:93c:c162:125b with SMTP id
 af79cd13be357-93ebd259adcmr1669728485a.39.1791818293617; 
 Mon, 12 Oct 2026 08:18:13 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef5086fe3sm7202685a.37.2026.10.12.08.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 08:18:12 -0700 (PDT)
Message-ID: <53d3b17d-0004-4e97-a410-30eb0d500d9f@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 10:18:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] semihosting: use new semihosting ops
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-10-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-10-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 05mH7CzztrnX2A0VaVjofYEdZxau0QI0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX6WzupoPOt5SX
 OT1HVTJdgdGboyL8HcxysG++KUtfReS+33KgYavSXWxNG7fEAC1AWsTcldLy3abHM+tak/Xc+Ll
 sc3//QH0r0q5ryPrefxwOC4EpZKu1Dc=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6accfa37 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=UHZotVYTJdBhq0owtycA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 05mH7CzztrnX2A0VaVjofYEdZxau0QI0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX0h6+xeCLLUBb
 8zOmgaGM/TgU6fN1qqMgNwfuada1Fb46fL8Byf0KtjDIEH1WhwbFfXYdbqadflaU4jTfckb0WhS
 d0SzsgFboN/9hHvTh4PrHR62YaNKIc6XMf2g4ssSirZHaQNQ3wJ58G45YGg+feAaTF40BdDMVSr
 qxbtleD8Vtm1xz46j8c5GcIvmgLMmqlEWYrEEkMRSbfUbeqzhmcTJGqfK85kVZoSQzj/RfhokJL
 InJvb03WF0t8/58oDiZmupVdBWx9Oj6qkDmBt5fsvGna7f4hYrvCjrLUhxCOmSEJk61CXDK2+be
 +e/neyJDaSpjCpoe4Kkv6JD7JNDLAkR3lNSf5LjSfXTReYg998fHxo3pIAldk4xbtfNLmpPzXIs
 hovQlWCc5rPqjI9LqNYvRxzIUjJz83mRSWQXkcA9TXpJjt3UrPlrGM/cIgLsmowhv34YghrzbVt
 P33JgrOw8yLV8149nsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120060
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


On 10/9/2026 5:52 PM, Pierrick Bouvier wrote:
> Now that all targets implement this interface, we can replace function
> calls with the new interface.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   semihosting/arm-compat-semi.c | 56 +++++++++++++++++------------------
>   1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index b930a028649..3117eadb3b7 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -188,7 +188,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
>    */
>   
>   #define GET_ARG(n) do {                                 \
> -    if (is_64bit_semihosting(env)) {                    \
> +    if (cs->cc->semi_ops->is_64bit(cs)) {               \
>           if (get_user_u64(arg ## n, args + (n) * 8)) {   \
>               goto do_fault;                              \
>           }                                               \
> @@ -200,7 +200,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
>   } while (0)
>   
>   #define SET_ARG(n, val)                                 \
> -    (is_64bit_semihosting(env) ?                        \
> +    (cs->cc->semi_ops->is_64bit(cs) ?                   \
>        put_user_u64(val, args + (n) * 8) :                \
>        put_user_u32(val, args + (n) * 4))
>   
> @@ -237,10 +237,10 @@ void common_semi_cb(CPUState *cs, uint64_t ret, int err)
>           ts->swi_errno = err;
>   #else
>           syscall_err = err;
> -        common_semi_set_err(cs, err);
> +        cs->cc->semi_ops->set_err(cs, err);
>   #endif
>       }
> -    common_semi_set_ret(cs, ret);
> +    cs->cc->semi_ops->set_ret(cs, ret);
>   }
>   
>   /*
> @@ -249,7 +249,7 @@ void common_semi_cb(CPUState *cs, uint64_t ret, int err)
>    */
>   static void common_semi_dead_cb(CPUState *cs, uint64_t ret, int err)
>   {
> -    common_semi_set_ret(cs, 0xdeadbeef);
> +    cs->cc->semi_ops->set_ret(cs, 0xdeadbeef);
>   }
>   
>   /*
> @@ -260,7 +260,7 @@ static void common_semi_rw_cb(CPUState *cs, uint64_t ret, int err)
>   {
>       /* Recover the original length from the third argument. */
>       CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
> -    uint64_t args = common_semi_arg(cs, 1);
> +    uint64_t args = cs->cc->semi_ops->arg(cs, 1);
>       uint64_t arg2;
>       GET_ARG(2);
>   
> @@ -268,7 +268,7 @@ static void common_semi_rw_cb(CPUState *cs, uint64_t ret, int err)
>    do_fault:
>           ret = 0; /* error: no bytes transmitted */
>       }
> -    common_semi_set_ret(cs, arg2 - ret);
> +    cs->cc->semi_ops->set_ret(cs, arg2 - ret);
>   }
>   
>   /*
> @@ -302,7 +302,7 @@ static void common_semi_seek_cb(CPUState *cs, uint64_t ret, int err)
>    */
>   static uint64_t common_semi_flen_buf(CPUState *cs)
>   {
> -    vaddr sp = common_semi_stack_bottom(cs);
> +    vaddr sp = cs->cc->semi_ops->stack_bottom(cs);
>       return sp - 64;
>   }
>   
> @@ -330,7 +330,7 @@ common_semi_readc_cb(CPUState *cs, uint64_t ret, int err)
>           CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
>           uint8_t ch;
>   
> -        if (get_user_u8(ch, common_semi_stack_bottom(cs) - 1)) {
> +        if (get_user_u8(ch, cs->cc->semi_ops->stack_bottom(cs) - 1)) {
>               ret = -1, err = EFAULT;
>           } else {
>               ret = ch;
> @@ -385,7 +385,7 @@ void semihosting_arm_compatible_init(void)
>    */
>   void do_common_semihosting(CPUState *cs)
>   {
> -    CPUArchState *env = cpu_env(cs);
> +    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
>       uint64_t args;
>       uint64_t arg0, arg1, arg2, arg3;
>       uint64_t ul_ret;
> @@ -393,8 +393,8 @@ void do_common_semihosting(CPUState *cs)
>       int nr;
>       int64_t elapsed;
>   
> -    nr = common_semi_arg(cs, 0) & 0xffffffffU;
> -    args = common_semi_arg(cs, 1);
> +    nr = cs->cc->semi_ops->arg(cs, 0) & 0xffffffffU;
> +    args = cs->cc->semi_ops->arg(cs, 1);
>   
>       switch (nr) {
>       case TARGET_SYS_OPEN:
> @@ -494,15 +494,15 @@ void do_common_semihosting(CPUState *cs)
>   
>       case TARGET_SYS_READC:
>           semihost_sys_read_gf(cs, common_semi_readc_cb, &console_in_gf,
> -                             common_semi_stack_bottom(cs) - 1, 1);
> +                             cs->cc->semi_ops->stack_bottom(cs) - 1, 1);
>           break;
>   
>       case TARGET_SYS_ISERROR:
>       {
>           GET_ARG(0);
> -        bool ret = is_64bit_semihosting(env) ?
> +        bool ret = cs->cc->semi_ops->is_64bit(cs) ?
>                      (int64_t)arg0 < 0 : (int32_t)arg0 < 0;
> -        common_semi_set_ret(cs, ret);
> +        cs->cc->semi_ops->set_ret(cs, ret);
>           break;
>       }
>       case TARGET_SYS_ISTTY:
> @@ -533,7 +533,7 @@ void do_common_semihosting(CPUState *cs)
>           len = asprintf(&s, "%s/qemu-%x%02x", g_get_tmp_dir(),
>                          getpid(), (int)arg1 & 0xff);
>           if (len < 0) {
> -            common_semi_set_ret(cs, -1);
> +            cs->cc->semi_ops->set_ret(cs, -1);
>               break;
>           }
>   
> @@ -542,7 +542,7 @@ void do_common_semihosting(CPUState *cs)
>           /* Make sure there's enough space in the buffer */
>           if (len > arg2) {
>               free(s);
> -            common_semi_set_ret(cs, -1);
> +            cs->cc->semi_ops->set_ret(cs, -1);
>               break;
>           }
>           p = lock_user(VERIFY_WRITE, arg0, len, 0);
> @@ -553,7 +553,7 @@ void do_common_semihosting(CPUState *cs)
>           memcpy(p, s, len);
>           unlock_user(p, arg0, len);
>           free(s);
> -        common_semi_set_ret(cs, 0);
> +        cs->cc->semi_ops->set_ret(cs, 0);
>           break;
>       }
>   
> @@ -572,7 +572,7 @@ void do_common_semihosting(CPUState *cs)
>           break;
>   
>       case TARGET_SYS_CLOCK:
> -        common_semi_set_ret(cs, clock() / (CLOCKS_PER_SEC / 100));
> +        cs->cc->semi_ops->set_ret(cs, clock() / (CLOCKS_PER_SEC / 100));
>           break;
>   
>       case TARGET_SYS_TIME:
> @@ -587,7 +587,7 @@ void do_common_semihosting(CPUState *cs)
>           break;
>   
>       case TARGET_SYS_ERRNO:
> -        common_semi_set_ret(cs, get_swi_errno(cs));
> +        cs->cc->semi_ops->set_ret(cs, get_swi_errno(cs));
>           break;
>   
>       case TARGET_SYS_GET_CMDLINE:
> @@ -734,7 +734,7 @@ void do_common_semihosting(CPUState *cs)
>               for (i = 0; i < ARRAY_SIZE(retvals); i++) {
>                   bool fail;
>   
> -                if (is_64bit_semihosting(env)) {
> +                if (cs->cc->semi_ops->is_64bit(cs)) {
>                       fail = put_user_u64(retvals[i], arg0 + i * 8);
>                   } else {
>                       fail = put_user_u32(retvals[i], arg0 + i * 4);
> @@ -745,7 +745,7 @@ void do_common_semihosting(CPUState *cs)
>                       goto do_fault;
>                   }
>               }
> -            common_semi_set_ret(cs, 0);
> +            cs->cc->semi_ops->set_ret(cs, 0);
>           }
>           break;
>   
> @@ -755,7 +755,7 @@ void do_common_semihosting(CPUState *cs)
>           uint32_t ret;
>   
>           if (nr == TARGET_SYS_EXIT_EXTENDED ||
> -            common_semi_sys_exit_is_extended(cs)) {
> +            cs->cc->semi_ops->sys_exit_is_extended(cs)) {
>               /*
>                * The A64 version of SYS_EXIT takes a parameter block,
>                * so the application-exit type can return a subcode which
> @@ -786,7 +786,7 @@ void do_common_semihosting(CPUState *cs)
>   
>       case TARGET_SYS_ELAPSED:
>           elapsed = get_clock() - clock_start;
> -        if (is_64bit_semihosting(env)) {
> +        if (cs->cc->semi_ops->is_64bit(cs)) {
>               if (SET_ARG(0, elapsed)) {
>                   goto do_fault;
>               }
> @@ -796,12 +796,12 @@ void do_common_semihosting(CPUState *cs)
>                   goto do_fault;
>               }
>           }
> -        common_semi_set_ret(cs, 0);
> +        cs->cc->semi_ops->set_ret(cs, 0);
>           break;
>   
>       case TARGET_SYS_TICKFREQ:
>           /* qemu always uses nsec */
> -        common_semi_set_ret(cs, 1000000000);
> +        cs->cc->semi_ops->set_ret(cs, 1000000000);
>           break;
>   
>       case TARGET_SYS_SYNCCACHE:
> @@ -810,8 +810,8 @@ void do_common_semihosting(CPUState *cs)
>            * virtual address range. This is a nop for us since we don't
>            * implement caches. This is only present on A64.
>            */
> -        if (common_semi_has_synccache(env)) {
> -            common_semi_set_ret(cs, 0);
> +        if (cs->cc->semi_ops->has_synccache(cs)) {
> +            cs->cc->semi_ops->set_ret(cs, 0);
>               break;
>           }
>           /* fall through */

