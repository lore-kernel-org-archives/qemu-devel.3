Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AF8C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIVV-0004J0-06; Wed, 26 Aug 2026 14:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzIVS-0004Gd-QY
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:37:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzIVR-0001OO-6w
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:37:50 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QHMA5F1044511
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JCwYThXifyy6LfW29TURN+uYYGzGJkJKgx2XvULwgnY=; b=kfv/+SBhdXsHWsxh
 pw95aOiEaMmuT9ofByLsvf5yLpH0m3nLuxdh1e8lIzTnyIVjAVte+mNR572h/1g/
 7O5SsYfghCXh5pk+PkoK/m8zs6dYsN+41qOiUKF/tBcnWiq9qE0aW2vowhYDV/w1
 usy2msIlDUH7jFvAkqXZJiQ7qtFb6B/6HgG6JrdlUSgL9PUpgNuJBV5m8ANGQIbx
 KNX8Od1aXj9I2s5U9mp2TxXtSUguZ7OkWh3eBPyGiPAGzqzbPq2U0W1cmos4uVHZ
 5HEGmtdEeb0Aolm8YIUi6lUTPYJ4vaRY2lfPOkSeljJqgWVI8HItnANXygE7zSYw
 xZGNLg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4fwg9qf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:37:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so13334051cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787769467; x=1788374267; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JCwYThXifyy6LfW29TURN+uYYGzGJkJKgx2XvULwgnY=;
 b=ZDAVexhYO83HR8GY4Tx5UG8Xs2UUrEMC3ZM2m8bbothZ+Coqp7VU4d2QGnmdWVkqyG
 vbaAwP1NQZay+GDmo3rZeOHLE+DfIvIP58SCcV7hQeIoZ2sGOid+4nJUAfY8sDD1xAQx
 sSBANvIbDsB6xQmXw949sbsN7MdBc+691wu4WmNZmgXB5SIZtG9MpcpNgItf1G6y8EUL
 +HhSYHsKSVV5DWHrKHIsHPoVNnRdUGeVATy+uRrzVyumF1Ci1Ci3e360aZGu6vU2u1YQ
 qGMC0OgGEdBwXl3VVVEl6PSqzHMwhkZc8IPIJT+Q5ioqEiqIDM4DrHfwQkBoDaiBc3BA
 unSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787769467; x=1788374267;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JCwYThXifyy6LfW29TURN+uYYGzGJkJKgx2XvULwgnY=;
 b=ByvQHcDTVO8P0YBjHlZumad012u07eOglbI5t++avvoWzlweRP1NfzOR5LB9OAqTFu
 qsNMtlmAkhER5C+bW7Ji7zHSVSUQexL9ccFD8zDTzb1K/hgX7qyx4S5tl+AePIB9gwO7
 VVVhPBjprLIvthewgnwk7ATO57fYwV2z+BiIfE+pDAhL2kBJfjqk8rDW0VecNBDudKUW
 D6kuj3p7ir3OHqiMXGEDZMzkLnVh2iQ/pZ/JYjFDRZujTuIXMIL/ZWQ6+TAXlkxqz7rZ
 liRrxYD4Aqs1GOnbSXQKM+IiV7BKivpw5bTGt1/ycG5MugWtFzR1VL4aHZlTENrX0CEN
 coOA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9Y4M84lY0UaiyQ5/CaZqu3vgyPLbIrhmzl++Cnlt0aoByJu+YO+kBB5W1FeGnAhLR0ajLGA1x1Cu/@nongnu.org
X-Gm-Message-State: AFuF++kMICUy2HSxqV76AwHWVdQI3wqz7+w/DCaot2iMo9LanIxRNpqF
 nX1OsW/zPrXrBRhW/XeqyruCmApDzqXmSdd8cbn7umJHPIqK5xcAh3cAPXmLReA3MpvoSqRLlm3
 112NBXVv49llPG0lHDsGbi2hxZNh587HxRKvwc9AR/nzYx9anHNeZQsx8OA==
X-Gm-Gg: AR+sD10iLLSW7evrgYpTR72Pk84Ify73EMeCdDtDmF2a4NrtG75lw7HkH+ZNoxO4cUw
 XdVzs5B6WxKBoM97MXaTL3k55bPt87/V69qEaVYGXRWtBPeQUnLzUX/tGSWz+TX4xEYXmAJFHkI
 9/QyIYLw0dhZBlj6REWyn+LuCQgXcapxn83P+Gim1uw7oGJDRAcI7R6Ed/nz/ikMv188wwikqek
 dGxqb84OZw6I0/iKmggXpF4FCjaPcL0y5DGSETNngIf8V4dHvAkTSm5RHJ30wGjII06oE89Kr2b
 bYwbqGZV2JjgpJthFXjGqYrm/cLy6heoybReP7FZlao7olnSj0WXcnX9B8A609P2NOladFhkd4/
 cr7qRVuXLjXE6WzT/iz1ZXV9etVZU+gSfHKUVKgeNBcf7TC0c/w==
X-Received: by 2002:a05:622a:1111:b0:528:32b1:c202 with SMTP id
 d75a77b69052e-52e42235670mr90965331cf.7.1787769467128; 
 Wed, 26 Aug 2026 11:37:47 -0700 (PDT)
X-Received: by 2002:a05:622a:1111:b0:528:32b1:c202 with SMTP id
 d75a77b69052e-52e42235670mr90964331cf.7.1787769466529; 
 Wed, 26 Aug 2026 11:37:46 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a6fd00csm662040566b.15.2026.08.26.11.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 11:37:45 -0700 (PDT)
Message-ID: <11ab11dc-aa98-467c-bd36-4dad90bc0069@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 20:37:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] target/riscv: seed cfg.big_endian from TargetInfo
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <20260823150731.896-9-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260823150731.896-9-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EPUlcWcihGqr3qmn_2Rm5tTvy1atleoH
X-Authority-Analysis: v=2.4 cv=OtZ/DS/t c=1 sm=1 tr=0 ts=6a8f327b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=sk3sBhc6xHwubYSXd84A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: EPUlcWcihGqr3qmn_2Rm5tTvy1atleoH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1NiBTYWx0ZWRfX7YYYeSaYnRYt
 gMbxYLp+g5hPeY5ghz3CWt266LPyJX0jRH9caGVSdSF/6hH8GGioj5y9ULmQd3+WAG8q7sXUCEq
 Ovl4NvjfTFgHeJH+FE4jbI+uMQAhG7feaVNYXNVaB/4VVEJdXjJBoyKcpAkZoPbN0HQJG59z14O
 8D8cQ2XdGfgsp/WPcRu8yvnys8ixwMrKBBbkgt3Z+Ch+7LvNLzjFOXALhGxtgv6K6v/+gFBWbOW
 /YQA52fwsD9tD9LUyGTGoE7caQ10tF7SY8xh9cbklcq14VD0iUcPa30E0mjcrYPBv/dysWJTPXM
 8ikh4tpKXr0y57ALwtw/OZ1ZS2zxlsyf2pDH70fytldRGSteRaePl4hpnA+ezRiKlNT3l1qhP0n
 MG3dlGsTtGtdrjQMjRYAh8PK5hgpFq49PgWJ4g9KpSHqPM9oBdxT0eolRi8CTWhCM2ZqKrIM98B
 Svl1uZDFc9XtzpjolIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1NiBTYWx0ZWRfX9I0EZA/TJg9i
 AsejrGFc5M27QVwtPUJ9D+aYni1H8hWRBL0OUnSr2naBGD/AbXl8vebHYTmMawl9aszzwZEtUx8
 8yaFNHVx0ehPGgx5IcPbgtC1Uy0trlw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260156
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 23/8/26 17:07, Yonggang Luo wrote:
> GDB register packets use target_big_endian() only (gdb_get_reg16/32/64).
> RISC-V gdbstub already goes through those helpers, so future GDB
> big-endian support does not need a second endian source in the CPU
> gdbstub. It needs TargetInfo and the hart to agree.
> 
> Hart endian is cpu->cfg.big_endian, copied into mstatus MBE/SBE/UBE at
> reset. The CPU property still defaults to little-endian, so a
> big-endian TargetInfo would make GDB swap as BE while the hart stayed
> LE.
> 
> - Initialize cfg.big_endian from target_big_endian() in cpu init so a
>    big-endian TargetInfo also sets the hart.
> - Fail realize when -cpu big-endian= disagrees with that selection.
>    GDB cannot follow a per-CPU override, so a split would silently
>    corrupt register byte order.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   target/riscv/cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a82e6563bf..0681bec0bef 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -29,6 +29,7 @@
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
>   #include "qemu/error-report.h"
> +#include "qemu/target-info.h"
>   #include "qemu/timer.h"
>   #include "hw/core/qdev-properties.h"
>   #include "hw/core/qdev-prop-internal.h"
> @@ -1226,6 +1227,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
>       Error *local_err = NULL;
>   
> +    if (cpu->cfg.big_endian != target_big_endian()) {
> +        error_setg(errp,
> +                   "CPU big-endian=%s does not match selected target endian",
> +                   cpu->cfg.big_endian ? "on" : "off");

Surely the bug is on the GDB path.
> +        return;
> +    }
> +
>       cpu_exec_realizefn(cs, &local_err);
>       if (local_err != NULL) {
>           error_propagate(errp, local_err);

