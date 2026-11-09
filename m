Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB3606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KcxfJZek;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FSoxcT6Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVUV-0002Rl-PO; Mon, 09 Nov 2026 14:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVUL-0002O3-SQ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:57:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVUK-0003vv-Ds
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:57:09 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHHbg4001655
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 19:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /QJ1yQZXUdHl6VLmD98JD2CL7LZGLN4++AjAtaBTGjo=; b=KcxfJZekmfvdIh0j
 IjwEyKvw3yAwsRY/YuZmQh+B+pVVRliOFB1Opp0ZZ2PDzH5e4m4RRd0L0w+nkKj6
 MZudqfCgpzpxMcU7RfQHzHzQuzNRwsitoMlQqFvopTcSYbJ79s4lDLtSZBXu/SjX
 znPDLcjcHkvYEuPT4UAMEtsmVCgsjPU+/0sw0Wu+131urgtLgxZ01rTlJ+L3ieyS
 /BXsv33oF2UUWi60Vkev16eALDxL7YI4KO5iTkIqYxx1LymyAiJHnGOKY2CZ7Kct
 PrzMGeHaFS5TvZlDlaHsHpvDDeZ+7aZ+OAWOnI6EsDDN5o0C4V19fNM9Yy1iCcYk
 4JJM8g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0rssdb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 19:57:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e92aad34aso323414685a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794254226; x=1794859026; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/QJ1yQZXUdHl6VLmD98JD2CL7LZGLN4++AjAtaBTGjo=;
 b=FSoxcT6ZGgrFmGUZBYxGP3d5W/4pfEQvwueKPnEvg5XIygLF09qZnwFolmbDFm665u
 EMYza8JS0DkgfMg9ssx2Syt1I3qnrEPkfLMLfZR09JFqv7ErREzgr/2xMK/51ImExkV8
 w84Q944fzc8Q1U1GLWfzMStTj5cau9j37v9xD2g0a5OIkt6ao4OKBaNdOZSmIg4c51BE
 8B0CoXefrsAg6q1nP6KOf6BA22OuY0El5kciCltrI0B0RED77vUsLjQ//7qk4lreY6mX
 KyfARUn1s2uwLgfZxFFe8Ttr1YUqlA3jvt8Nb36RpPdILv646MthkqxsnST+0bcOLuVa
 O8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254226; x=1794859026;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/QJ1yQZXUdHl6VLmD98JD2CL7LZGLN4++AjAtaBTGjo=;
 b=LlBnmwU2E4GrvpK1MaxVBFaKHNJFXYDaVO+2Z7HfC+R+yCxYKvPrTD6yKoJBwl3xge
 KsQkYtBbuFMN0inkrWXXpV8Gn9u+T9AA94e94bsxGsQ8CQWE+Olp+Oo7JGUCGumsuBau
 pqLY81qxZxt8kdoQQyb8iiNqCl8iZ3anCxdlS2Bl8fJoNE3kyFE0EhQVNkASAndomU+E
 0qnM0CkzjCRNjNsWrXzLsPJwTiJMBejJaN+AIWtvvtVquyuLBsPxr8m2Ovi7L2EcbUdQ
 ZGrPf010F2TtnComy+VYfZRodhukrjRBraEfJJd68783dMu/FKj6zWqKkO9+9oSqZaQl
 GlEg==
X-Forwarded-Encrypted: i=1;
 AL+hErGQC90Ww37k9nWQSTpypzt4K+7ZsJoq9wW+LVsWX0BjzoFVW5DYeTn2pqr58jz+NYj9bAVhM3Ne8xRv@nongnu.org
X-Gm-Message-State: APuU4Z/d/zYC9V3LM2/SnomeKlJ57DI51xLBu5UjDcB7iQvqwbEX/z2E
 iv11NF9hB2ilRq+UQEMbI9ChjHPya2/FiAco4lsATKpxIGS43ZZiFOWNSTkDDW0QpOnXlKz1mIo
 LRtPWGBP0AelAjmKUqcBfdmT1vrdxsQC7TsQVRszKr8xUbcg/dHSPdRpaiw==
X-Gm-Gg: AYBFou2pv+inb3SVYzR8WTGw13YIx5jrEDKWAXr0dmLb7a1mTrpK6reE/tM0KN2KSKr
 GQ2B9Y6yfXsuh8bkc2V4WlaOvXKM+8q5qs4EOWtSjaC2InWX5TXPDWj7OI2UF3lLWEvGzFolH9G
 lpOzqLZe5SZE0jY7rRz95Mnv8bmHrrDyFeay5oXMV8J2D9XzfmtUt6XKzbM8+AbOdUw5JXzcLaa
 HC9hWmnDEw7vQy/GVKRs+zGbPYNwf226J2Ap7gUq+z8SmMlt9pn1Z/H4vVUso9gY00IhzjmhnK3
 QLXpfI3dTD34ZzydJfJY0io0ULiNL59x45EhIHAZPntZJZazf8DwyiwcDWP0Wg5qw/u9QVvvFtx
 zYMDK6czHqI3EVKzbBIEDeE5Rl9JAsfBjH8lHVL1u9XT5Rr8MrEzSw4AAKu8aM6b/JFm8RyMpn9
 9+AjJ7XYOF
X-Received: by 2002:a05:620a:4049:b0:93f:5717:e7bf with SMTP id
 af79cd13be357-9479f2fcbefmr90614585a.46.1794254226490; 
 Mon, 09 Nov 2026 11:57:06 -0800 (PST)
X-Received: by 2002:a05:620a:4049:b0:93f:5717:e7bf with SMTP id
 af79cd13be357-9479f2fcbefmr90608885a.46.1794254225924; 
 Mon, 09 Nov 2026 11:57:05 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e785557sm52335585a.19.2026.11.09.11.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 11:57:05 -0800 (PST)
Message-ID: <fe869235-3586-4dc7-ad4d-7f2e7d8f36d5@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:57:02 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/38] target/riscv: Add implied rules for Zvqwdota8i
 extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-6-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-6-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lEmnq2bvk6uNfa2FxN0parskgGivRkcQ
X-Authority-Analysis: v=2.4 cv=MpfHeGae c=1 sm=1 tr=0 ts=6af22593 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=zapYC8F5DdXOOChKbMkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX3mpcuBQuVaUF
 raX3oiFBOQZQEmOeczlGFgbRP258mj4QxWhQ2tu1pBIBwZK5cHZ+GtYcOOhjAcBMLjRAKPj/QO1
 LYwa83NQGWlDz/dk7Yw9P+uwU9qXsqB8HU6cbEK1FMCt1mnx0I8ezuu2zXYrU1J5Cux+ECuTch5
 LS901nebRBLhR6ldagi7kdB/RiDE05bk4vd1hKN4lPcjFjmEDB/YPUBtMDGb7wgUo/oXvzXGfee
 b801SSj6qo9uoIFb4E9JHAZbL1x1JCsFFSrKO9Z1LW26y+4LpCx6WExho3qy8n1CJaonVspiDi4
 46hV/Qa0BQxR6PMrn+8DC6vmj141FRNJBKYpwBYy70LTCXca+ymE9IX3NpTPiLh9EzlV6GbTLef
 WfsIk/MRcLeflzlCO8zWrvwnv1IsIFCOgTuY0ci1Wk8dMiQtF5WHE0jHTQ2zsyGp1jW41xxtJAv
 zBQOE4dA5gzzxpnqAfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX+8ibM7Fgal+q
 Ro2/bWoVbLrsPGV/JzMHXWY8yZUVHaYsZ3osWaHnHRdBVR5zCgQhsia/dZQ4SLxruZQ95/lftUf
 uD2D6oPIwgdp288maFyyoz/vTA44nY0=
X-Proofpoint-ORIG-GUID: lEmnq2bvk6uNfa2FxN0parskgGivRkcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Add implied rules to enable the implied extensions of Zvqwdota8i
> extension.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 96a1d76c5a2..08b14782451 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2851,6 +2851,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvqwdota8i),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zvkn),
>       .implied_multi_exts = {
> @@ -3055,6 +3064,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVKS_IMPLIED,
>       &ZVKSC_IMPLIED,
>       &ZVKSG_IMPLIED,
> +    &ZVQWDOTA8I_IMPLIED,
>       &SHA_IMPLIED,
>       &SSCFG_IMPLIED,
>       &SUPM_IMPLIED,


