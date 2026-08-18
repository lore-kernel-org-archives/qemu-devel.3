Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E87AC5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwCUR-0002x7-53; Tue, 18 Aug 2026 01:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCUP-0002wN-Jg
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:35:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCUN-0001KY-Ok
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:35:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I12JSF297628
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tv8WEFvTLP0R36e98eKcYUGWi2SVM1jZ3sBvl+YnnPA=; b=l5yJRCXqhfs08D6q
 IWcbOUoGWIo8G/McXRs8pt/nDztZxFesKZKcdyJyyZY6lu2mq8XnG/pLxPFmhzB9
 jhMJrzT2a2OPCmqJI7HB+clonXiLzS/L9tkwlyeUhKbaAqjXeAp5NLERglSTNZHM
 oKzUUVMqUCiqk8efxgzDj5mN8ISnF9re/uNYkL2f1DSx7GbhXJsBzqm8bTEPDbFP
 lCrKTFHSLT9DNYPnFNJoUlANeihj5sff+Nnvh+cc2h1aINM6HIXuXshB7uO73ZUu
 KWc1vIWKgYj64+1uYGNfHFkNo03pgBtRsg+I3HeLjvW3kHJ9I5h5IndTT5IByHFj
 dtxWDA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4dcn0yvn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:35:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934956beec8so713852685a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787031351; x=1787636151; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tv8WEFvTLP0R36e98eKcYUGWi2SVM1jZ3sBvl+YnnPA=;
 b=DsY/wT2GDQEh835cZ4ARUBt0b5QmeTpt1QUIpw3b9PjWpfhFQ5kJ4Xb1hu1CxMEktQ
 PJ6GxXWLRh8GkIXUX5z7HsUEaPXe4ftSj5l0r8lwjfdjcXi6Sydl4t/enrjufuQun9I2
 YDsW8BkFdSkmqeX2dDYMzW9uGjdKej6kBbG0/2u8Z0HgYmitPMceXJaOtDhN2WL+Drrl
 CRLsQiw0Tx4YdtiUVNjJ7k9A5cSdAFX0jtU/q9AnZXGlE4O9Hx7qQlzNPYf98/L+9mqb
 8+pwYuamUWobL4KSXx1dy5GPO9TgQRGpiaF7wGZ05Ymh+S++/PcC8N1KlDFwMUdC+ynC
 +FjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787031351; x=1787636151;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tv8WEFvTLP0R36e98eKcYUGWi2SVM1jZ3sBvl+YnnPA=;
 b=V1v6KrYH44ACK6FLCIbhTAqycqjiyEmBal22X8g3RB9Yi4HqiF+/XeWtoG9bfDRidb
 MXDlGSs6dm7I/HSu3x4+ZBo9vypejL9oBN5fMpltSsdlGxe2Va4oSh7L4ggWqrsPBqYM
 n03ex8gbTx6uyt+GSGfWYEjA2DIs7X2TZwib0vbvYzRBwQcopzC98TwQTlLvmA9FTju6
 cwgplQE7e2mjWEkobEq7+BMSSN/3d8CeNSeoZQ2OPGP2V6Ls5bzRn4TeAaIHjR2l90cC
 dtBkpo1EijHzsnuRTjg5j+TMq4vqTfLdBnWhetByxFgiQ+vs/khOug6Awv6TVUrBiyDH
 Jovw==
X-Forwarded-Encrypted: i=1;
 AHgh+RprKW1FRBAr3CZhS1/IeOLlkvuhWLMCLc1heFo5TGK7NKElnA1HumT0GMJQ8Lbjqd7NOk5FDlnwfLJH@nongnu.org
X-Gm-Message-State: AOJu0YwmxM0ndF0Xl9DcIu4NpZD5HoDaYbB4hV46lJ1WgNyCd9GQOhfD
 jkwl76L6OiKcYwGOnb/wWDoF309hATf49Qkotb3oPZ0hzBV2GRn7Ugnb1y1t5ze6pvpo6D2sHi4
 teyue9TSHGiCvDkz5UsHKVs/N5iU7rvpt2G/gENLeDBpifENuuAicw51+HA==
X-Gm-Gg: AR+sD10UYOD7sF/0Ndk/u1YO91WcX8sbRwIi8nKnGSowlyOWSnGXQ4y78EMJu5Q+jMt
 S6KJaIdCPl00XJpG3C3KYQUcozp1G7/D9kkwfA6jU8MW6G+Dp0no2Q9hbVlVweTStaHXnBukFNt
 THso9INVRivjS0ApqCtBsjr+iES52UBCWyqQ2iry90gEmps4eg2enBdK+dHXBAkVx9LeafqN8mY
 fhaesfM6kg2lyotuDkh5PUHVXU1QG4mbsxzH3g77+u+jcU3CioFzn4HItIsUFK84YP2cJFBKvLO
 3AizZJc5Xe33YZznnTZXIKFCRsufig/aT9RlOtmQlu3fUH+tsBrnjIZut0DAxfau+qM0NQJzZOl
 CRTcAX1dsjhllpA/XSaQNh0bYBB4HxbguLCg=
X-Received: by 2002:a05:620a:2814:b0:934:a12b:1d41 with SMTP id
 af79cd13be357-936d22ff13dmr3080562985a.33.1787031351170; 
 Mon, 17 Aug 2026 22:35:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2814:b0:934:a12b:1d41 with SMTP id
 af79cd13be357-936d22ff13dmr3080560185a.33.1787031350734; 
 Mon, 17 Aug 2026 22:35:50 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7bc6esm9715502f8f.19.2026.08.17.22.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 22:35:49 -0700 (PDT)
Message-ID: <6cc52634-67d1-40ce-8787-e166683caf31@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 07:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/18] target/riscv: Pass first/last to
 get_physical_address_pmp
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260815203730.1468365-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _iVk639uu9MkVluMlsbsPmgbojUjR5Iw
X-Authority-Analysis: v=2.4 cv=Gs5yPE1C c=1 sm=1 tr=0 ts=6a83ef3a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bSeteNioDOwiHrVFRtoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _iVk639uu9MkVluMlsbsPmgbojUjR5Iw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzOSBTYWx0ZWRfX7QJkxdkPVhC+
 zcLUQuxlcPydOnJOzYGeQjP/BUPGa9f2pphjXF0jOx1AuP4SZn5RiwR5DaYTshZnZMO7Zq0SrAx
 zIV3fjXSMvRXcffrSmR3csziFVWu0Ms3uAn05/lk61QEE1VN51UGZuDJVnMrGCBADHE+6cxKXgq
 dZqsKI5M+mopw7EIgntsSojK3OoPefOS53vxnkCWrGzMuQdSDyoxiNeU1YnaiJpzWRWjFK4F0hz
 fxtUTdukL0Ne+93A61ycIkHbJ4eF7Ub5PeRwCoOsnrdbyd5LbFRy5mFyTlRHeFOHpnUfDDGo6yU
 +AlouMP0c4Trwq0HfMv478tvVPgOYdiklDlbfqBEz8MyQnYTnCZVYaorcC7ozajvAN+YZViWO/M
 YZUsZukghLKfrz9+1HDa8w+VE2wm/BV96UIxPNFjhkARln2hfDFABfkwbCte6WH4fPcNKUT1ubj
 amwBWHvBQlhaJgiFnjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzOSBTYWx0ZWRfXzGBX+jvmnKJH
 +BCJ4t4kwOdaIXZIZVDPDGowf2C28NSeJfC7LespJXg30PGl5PbzqIgXjdWOMgfQHtC9iQfHCG1
 tcW3oqpbivtL6H44QmmBKYT3rDA4JBM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 15/8/26 22:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/tcg/cpu_helper.c | 48 +++++++++++++++++++----------------
>   1 file changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index 3318e82ea7..fb1250a4b8 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -899,12 +899,13 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
>    *
>    * @env: CPURISCVState
>    * @prot: The returned protection attributes
> - * @addr: The physical address to be checked permission
> + * @first, @last: The physical address range to be permission checked
>    * @access_type: The type of MMU access
>    * @mode: Indicates current privilege level.
>    */
> -static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
> -                                    int size, MMUAccessType access_type,
> +static int get_physical_address_pmp(CPURISCVState *env, int *prot,
> +                                    hwaddr first, hwaddr last,
> +                                    MMUAccessType access_type,
>                                       privilege_mode_t mode)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Orthogonal, it would be clearer if get_physical_address_pmp & co
were returning an enum.


