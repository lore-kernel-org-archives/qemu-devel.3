Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30583CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCOzs-0001qr-CI; Thu, 01 Oct 2026 18:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOzl-0001pw-Dh
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:11:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOzj-00039h-Uf
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:11:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsawL2886360
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WJnir+zplbHriQ+7wsB+t4PtoS8ALV+KZNrg7PU7QUk=; b=c8lg40r73qZm2wcp
 BN3xtQzZLM5BUZBjsk4J41Z0TPNkYXCOrhjQwlNaf4SO+5VQQ4Ck9ONUJKXhh3QP
 ArP/UPUTlDhVLrTEqtA7fX3dvLAml8X5Brez5eBGwmJIDgpL3awkF1mu+s00CmX6
 kNrLAltMzm9ZjNW5nNy2GshqB+ZKI9MJCOLILcuMrTzFdDGn2rFS/Ld0rw/BFUba
 Qj9EOMJpvno/6GVZzZDjoV3G6uO/FtYGLpfzRBOnUaeyFL2XlLsRiaLHIyI/WT/P
 vNB9flUQuF8EH8bwAWEcIgxF3hkgP1fNTVE8v5mGwm8TpcpwLcdjGKArLkSTrOGf
 dT32ZA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1sdcj0p2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:11:14 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so6659600eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892674; x=1791497474; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WJnir+zplbHriQ+7wsB+t4PtoS8ALV+KZNrg7PU7QUk=;
 b=GDbphxh1GV4x6CSqZWzsivJgWyL0bT+80DJt9btIF3Sbtt/s0aBy6Hze5t/AaODRqo
 6SslsQ5UIBi/1BzXqwGTDWEHZDiC3fwTw18vWTjtUDPkW248K2JlqwPojdYkjkHoEZTZ
 zLdTKcEQFjJFMVdE0FVnnWZ/gtF4gDUxY0yUn4qzLFl8wsxMT+4uTY4b3q6rgsO2b2hh
 OaEOznkWus5r3cU9dtpq+iJPsCeXYtFD4nEOLx6XNflGhCls2dI1BdkiDiahZ2W1Wh55
 9qtyzsthrkNRmnIFnKB+27p1TgMsil4dA8p+FkAf2/JPbGJSTsOVYV04Ag73vJgzhb9o
 Lupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892674; x=1791497474;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WJnir+zplbHriQ+7wsB+t4PtoS8ALV+KZNrg7PU7QUk=;
 b=AtCW5QEtL0dPH/0qE9pgaBIlNqfy8ceWVzSCYoxH5Zhm5XXWgJHROpjxHyYWmEroLP
 1Jk1XbvuwD/sFemqwCZTCPHxq7GqXlQ/+A3xLoGucmx9oil4xXuuZsA5g8xeSFqpj4bx
 iyu/g4hTdOHi5yW9AvL61NBdAJKH3YhhfjO4DsuOi4qjTwxwANmezxNSGmCQYjaewXHG
 lArqxd91YxftSqfL/KGYc95Odqg4to8uRxYPGzD0epjXnz2CoSD1RoklMZnT5AW770te
 bxMbUMPJSq4Bix3fk/HfJVmCCYxCRAVNC+xFMt457hXEkgrfsP7yVdcEcNEmtLPJPBqu
 5UAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkD/6aL+C9JIWdmMUTqtvdalESpAdbFt2eHA7GPwhP5tu9ejovKJCHHtaeQG3LG+6RFk/xebwnPeIq@nongnu.org
X-Gm-Message-State: AFuF++k6cGtG/0vUExiQyq6PYoFQvuM18Ab7YddEZdY4Gsf0tUg8v0zr
 2wV7bDQXs3m6+QS2oEdUU8jHWDZUSRMBjhTBvuO6ghassTs7ufkcN/cboJE6YoW0FpPg1Sf3XOq
 0uKHBsbGzJEuAMmkn/27g8BYGxQtRvKvCZGCzVw20BsI/SgQ6cJnlwIVjRg==
X-Gm-Gg: AYBFou1+9HFANm8RlI9sGz3LaDD3FAiR/5Qi0yTpqZrbRIBtwXPSChys2g5abUURv+W
 GZ1pterZTKX0+3jSPS9LM/Vawr16nsOj+nI/KRGP/u83A4pNZ7rlEeP6G/zmRxVyIZhz2Ai7fjV
 SJ0SysatBiWLZN3w4NOJs+Anxmv9RIBZyZuJC6urDh8lBaLP/yAgJaeY5aAYEgMsEjSuqMT9aks
 3vNEnJSc7Xc/+eMyZq6wS5Pp71bIH4lKNHA7hPnC9ZZUxwAHd+/u18+gJIZ2enGZ16i92vbpBLh
 exCAIDoRni+fUQRTl77lsyEnaQ5R1vS9JyIkWv9qoM3XMsa2ir0eyUCCrxwZyffBasCfN4eibPG
 2G7KgSm1a6Okz2WM9Ik5GuEZqpw4GpqYUgpkQX5VOoX1qCGwso5Zfw3rwaFRbXhA8SYHZrw==
X-Received: by 2002:a05:7300:8296:b0:343:ec4a:2b29 with SMTP id
 5a478bee46e88-34f150eecabmr779852eec.25.1790892674018; 
 Thu, 01 Oct 2026 15:11:14 -0700 (PDT)
X-Received: by 2002:a05:7300:8296:b0:343:ec4a:2b29 with SMTP id
 5a478bee46e88-34f150eecabmr779829eec.25.1790892673453; 
 Thu, 01 Oct 2026 15:11:13 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14fd4dd2sm1191383eec.20.2026.10.01.15.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:11:13 -0700 (PDT)
Message-ID: <c04a396f-cd5a-438b-abdb-de55d6193e90@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:11:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] target/riscv: Compile cpu.c once for system-mode
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-10-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-10-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LmHblGagfHR2GmgKlx43ViFvGzzqvIYp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX5AKiY3PVuEc1
 4tC3Htc/68zRhIcfkijRaLGhwAeHtjAJZdnEzx7kmaBse5zdwhAgGxxMym5RMapLd5hiUAObsm2
 ht+e/9X3KZqzS3nOkTToZ3exAliVS9g=
X-Proofpoint-GUID: LmHblGagfHR2GmgKlx43ViFvGzzqvIYp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX1YJFBaflYrWl
 j7jk3u32+u784NIAPbyjn/hh7zh2WOVe/Ecc9xNPfOiD/u0EQjncWcWyv+C+qfe9dZpJ4ucSxBi
 PRvZNCkUSwMenlzQEnhf0ZOA7WlK0nh8DCmaxjkbPuoXZLGDNEZLyUlQYDPE6mzyYJ0zGgWXprs
 4+H3ZAQMkm+p3NRUw4vgMno0AX/TTtnzrgxzswD2qBSmQQtqCj6z2VcvNQ7PqDt0DjSXJrbDi5d
 b254nnkfH4s7g3O1miXD29Zf7ARHiYD7pzYVgndvMeqOktMN0ThlR1RXUc+OWaYCI7IM5NblDfo
 AaF16zeGL/GlmmUj05v4n9dM2N4IEDiJARay4tdt6VsK5N8V6BOLRP6L+Az+gGI0vox3f5DpkJK
 8HV/rK7v7RiU7apwCeRpPOdb8yMp7Pdc66qwIjhOhMncBss8C3XWX+IP50ACaoU8uyXWznqJsUq
 mrjvCgrGrHQJNVyFSnw==
X-Authority-Analysis: v=2.4 cv=D87SufRj c=1 sm=1 tr=0 ts=6abeda82 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-8lwRADQGCiaruQU8J8A:9 a=QEXdDO2ut3YA:10 a=VxAk22fqlfwA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010088
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

On 10/1/2026 8:59 AM, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/meson.build | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

