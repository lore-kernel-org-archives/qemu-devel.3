Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565C2CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWaB-0000qv-6j; Mon, 08 Jun 2026 05:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wWWa7-0000q3-Dc
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:47:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wWWa4-0000fI-Ql
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:47:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586RaLb2833828
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 09:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f03EcKtQvW3HjdFac+gMv+qkLfMCEmG41YPsHS7Ch7w=; b=LjtVRXdcObi+0FhS
 2O3lFWaGrrvG80BQ+4/NbjjOcuvJUNlI8zIhE+ug1b2MkK53IPft1BILewQ6csaZ
 y+fCETN5shgB7N43qopRjXOJot3LrwELEH09pAXluu4xwiTf7u2ojjI+hDd3sIVa
 KLskbtexlDQa6M/oTf9vcIadDD81Hc/HSMOX7Xaa5AI455mwMR5ln84i6hMYtKuD
 BiLZMuUv4OWfmHpkOXfnIEz3uvKI9fAtbWE5euvQLPPXdLho8KSAyZaFEtC5HUIa
 xYAShnEN4KH3Lm+whNm3kHrjOSOcBMZHPuLSfRTbymkdhUL76/V8uFHvaobwIDQt
 pLaXog==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4yfah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:47:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915ba226a9bso369733285a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780912057; x=1781516857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f03EcKtQvW3HjdFac+gMv+qkLfMCEmG41YPsHS7Ch7w=;
 b=I1540WUjA/6KF3NDhFuDWqZXmplqH5SH4kOnpQjFOJ97YPCdbJygc6hn0bGHeD1qmr
 xo8kEVmTiL6GFf2+8XB0lFATkhjPjXy/TDDRPdqGsEhivZvNMlpkyA5IfBAzXlamHEFK
 LUWyHh93SaSqr6Wqltcuz1UazWFCknEQHB8mhdDK/1RkVW6F9/qp9ZxvD7clzEtZXcwO
 AwDxwEIxjMVKFPM9Twxkvn8VSC7MYRH6jSIxIEUfcAcRGz6RwToNHjNiJcUmsYV4Cc86
 XXlSqZjJshsmQw+F6wtjDgfTAAkCsgPVRCiA9qjvHt02giGt9rp42FdFppYwXCDb4x5n
 gOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780912057; x=1781516857;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f03EcKtQvW3HjdFac+gMv+qkLfMCEmG41YPsHS7Ch7w=;
 b=R7E6CsNdi2YHtiXG5FDaXyleSL8nCjTZqrjIzBsZsp+x4A8QoSSr8pTaFQp9nPfxJf
 nf4Dffe7vBH5f7qd2LB54nwUtgBlEvqm7aec++TM5RVhyVmHH/sn5LzNuTEzc5T64VsF
 WPGAAmmS1hhEjgTiZ29iQcP0v+ZMFegFonxexaaDpn5ZrAxTqpbvg/zMPt4xgZWm3BQr
 5yySDQHK72KrkR57SpquSt7I0sknxKyIxQ812DErTMyusqvv4vSHKksY2Qc/lI1mC3KH
 iYissTkWTJ100EErv7hv8Stfa7joh8LEGulE3eKIyMe1J4Wk7OmxZeoB/+mGDvB+Q8Pt
 zUxg==
X-Gm-Message-State: AOJu0YxGCTLAxdhqBMnuJfhdm+hGogl3GBDSxDMbvm0ptw/J+hoxmzbh
 ORHUPEcdFTI9Xagehd4EVHZSvPlQY+cGh9/cqvfqhMMlz0yS5ICLvHZh1ejuuVewbI/nJ3FrybB
 XqW3yk3ZTv7vvADuOcYSk+IMBcgPhLTNPSDt3QL3vDne3gw8/eQRG7nv+Yw==
X-Gm-Gg: Acq92OFK0i4qSDsKR0h9+TgilEv03RKS09lG+uhBUYU52LF2G9DA77JQi+uWEJOs5pD
 4aLqBJeQFXpv/bVEsJYWn0zfwAbd5RLGSGo+pYNV7VPn4Y4R+OCo4KL8SCPQ/zjh9Nu2XIobK4Q
 sFgApH6elF0djCCgy1UHkyOT3+p2EctQZpM75EZMf60vyV17LMUjXbKV/1Qc77A2WsSJ8wLAk+9
 Q2GpGy4B71hj4cT5WPugEHrVPXkpI/ismxkw2EYezUBNCQDROnBl1WP9fpC7hzzpijbrWj6FC8j
 9tN2csNae+wIgoAy9+Nk9fjUFauomQvuwapJCR876RJx5t2OM6UMo3J797fV48nfUm+ch+I34GP
 HlbTAFxAUrmArOc8tXtjEWx6oyiJTxF8kRo3pkldFalkxenIfygWKOZ/MVQ+tPh7qc5+S
X-Received: by 2002:a05:620a:3182:b0:915:b9f6:71a1 with SMTP id
 af79cd13be357-915b9f674a1mr1340295085a.45.1780912056601; 
 Mon, 08 Jun 2026 02:47:36 -0700 (PDT)
X-Received: by 2002:a05:620a:3182:b0:915:b9f6:71a1 with SMTP id
 af79cd13be357-915b9f674a1mr1340292485a.45.1780912056179; 
 Mon, 08 Jun 2026 02:47:36 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00a4f4sm1801402185a.3.2026.06.08.02.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:47:35 -0700 (PDT)
Message-ID: <98b5f348-aac4-4be9-a897-95da11c19aa5@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 06:47:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] memory.c: make memory_region_dispatch_* report
 ACCESS_ERROR
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@mailo.com
References: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
 <CAFEAcA9WZLV_fsFRN7g9-3NdJ0ecXGYqJHbp6kPPpSAiwM5PnQ@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA9WZLV_fsFRN7g9-3NdJ0ecXGYqJHbp6kPPpSAiwM5PnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7LzJtEhKGIWpuomMESKUQ_DlanIwylLm
X-Proofpoint-GUID: 7LzJtEhKGIWpuomMESKUQ_DlanIwylLm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA5MCBTYWx0ZWRfXy2tiCHFo5hz9
 jNNy5/CWUo2QCMS0o8Kyfbw1zXtieCbTwbMNtr4L76zOB1suwMEDof6XL1ly72ZKlJk7RuaUkKI
 wswVtqc7OdtrXb7f/jtWDe5thN6qiUk3lWJXrmzxqKEZsIFIXAz3TohW85AzMpfKpSfh9s/5h6O
 SBm+/S10a29qEKQUEUw/KJhpnTx73ScKSjgMjz019f31+PHUSKFrpzKm2mc/4LUe9ZNQwnwAP7n
 IabGXL4xbwVaS4Tv1lbdnPi1ADfwJuRJoDkRiZSt6Fh1S8CWrJrgtM3DrO14VQ4klddhTAvmYmL
 nuoPFTOosW8V+8tYwMiOubgefULQytd6j33iRz71vjCW8INIJOj3vnBR6+NNusyWhW/wcHdFiMb
 9Lvr+IHXpZ1dRrrEVBlDfgePArlj7wBZYXvpfRKqDL7acECZFWqtTHEIxImIRyJ4WpIZ/mUPxsV
 UTFtW6N0IIyGrNonS4Q==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a268fb9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Ar7ESL2ua37SciW2CGkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080090
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/8/2026 6:09 AM, Peter Maydell wrote:
> On Tue, 2 Jun 2026 at 20:09, Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>> Hello,
>>
>> I decided to propose this change after working in a RISC-V gitlab bug
>> [1].  In my proposed fix [2] I had to make assumptions about
>> address_space_ld* error return, which is always MEMTX_DECODE_ERROR, to
>> identify that in that particular scenario this is a permission error.
>> In RISC-V (and from what I can see other archs like x86) an ACCESS_ERROR
>> due to mem page permission issues will fire a different fault than other
>> errors like page not found.
>>
>> The core logic is on memory_region_access_valid(), which already makes a
>> distinction between error reasons when we look at the qemu_log_mask()
>> errors, e.g. this is being characterized as a 'rejected':
>>
>> if (mr->ops->valid.accepts
>>          && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
>>          qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
>>                        ", size %u, region '%s', reason: rejected\n",
>>                        is_write ? "write" : "read",
>>                        addr, size, memory_region_name(mr));
> 
> valid.accepts returning false isn't a  permissions error, though.
> It's for cases like "you tried to do a byte access to this device
> that requires 32-bit accesses only". Permissions errors are entirely
> in the MMU, and don't appear in the MemTx APIs, which are about
> transactions in the fabric outside the MMU. The CPU emulation
> catches permissions errors early before it even does the
> address_space_ld* call.
> 
> What is the equivalent of this in the underlying hardware?
> The current error codes are intended to roughly match the AXI
> bus SLVERR and DECERR error responses (which are "we were
> able to pass this memory transaction to a device, but it
> rejected it" and "we weren't able to find the device for
> this memory transaction at all").
> 
> The valid.accepts callback failing is always "we know the memory
> region but it doesn't like this", which is true for all
> memory_region_access_valid() failures, so maybe the problem
> here is that we return DECODE_ERROR for that case when
> we should be returning ACCESS_ERROR ?

This is the end result I'm going for.  In patch 1 I changed memory_region_access_valid()
to return ACCESS_ERROR when the valid.accepts fails, keeping all the
other exit code as DECODE_ERROR.  The ACCESS_ERROR will then be propagated
as an error in target/riscv/cpu_helper.c, get_physical_address():

         if (riscv_cpu_mxl(env) == MXL_RV32) {
             pte = be ? address_space_ldl_be(cs->as, pte_addr, attrs, &res)
                      : address_space_ldl_le(cs->as, pte_addr, attrs, &res);
         } else {
             pte = be ? address_space_ldq_be(cs->as, pte_addr, attrs, &res)
                      : address_space_ldq_le(cs->as, pte_addr, attrs, &res);
         }

         if (res != MEMTX_OK) {
             return TRANSLATE_FAIL;
         }

In this particular case 'res' will fail as ACCESS_ERROR if the pte does not have
the right permissions and we can throw the right exception.

Now, considering what you said:


"Permissions errors are entirely in the MMU, and don't appear in the MemTx APIs,
which are about transactions in the fabric outside the MMU. The CPU emulation
catches permissions errors early before it even does the address_space_ld* call."


I can say that this isn't happening in the RISC-V backend at least, so maybe the
core issue here is that RISC-V is skipping steps in address translation/validation.


Thanks,
Daniel

> 
> thanks
> -- PMM


