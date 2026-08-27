Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD27C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXP2-0001tC-Ja; Thu, 27 Aug 2026 06:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzXOw-0001s9-Fa
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:32:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzXOt-0005qP-Lf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:32:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9HJII2526945
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2DBINuFMm58bjywl49w88Q8ntiTVwCXL5/JJ9jLbOUk=; b=CT588Ai/L4MtbD/N
 pq8Hzn/5S/K/UAW7noUxqq8PUSoO+edGRyxiZWTlIamtFKtg2JFcp64403PYiAU0
 vSU0dz/LOi4Yv20tnK8c/81Qb0FZ0OpbIzyBfUoihuxJMeJl47wh/UJEEthVN9wo
 7KPSZZbUWfpdsJxEXyKHeKJ2n5YDBZmjJEcvMswyKPD6+IyeTz/DCv2XBng1WK4o
 atDyIiidoXG68p4cJWDifk1cNgw0c09CBjlxnpfrEMlgq+C0m/x2NtN7Ugb55Dp3
 BZF45Nb19hzxdHZVplGte1NIUqxjtdjROpEubp4P0AjxP228WPr0kLoUktEdHpLl
 4z3A4w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gab7t1x2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:32:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52827090cc5so9713851cf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787826720; x=1788431520; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2DBINuFMm58bjywl49w88Q8ntiTVwCXL5/JJ9jLbOUk=;
 b=i0SZEjX1wyX3SUOUJKze9oVZelu9Cq3RlrIEysjlERZ2sPrgvKBUuHlIdfyYBF3e1e
 G+uAaaLQ+qwOMuIRXhYjiOZrTlvm7GUepm64VfORt+OoHtPKWvs3jqIRk84xUaezkx84
 UKoOkX3BZDXojV/axPbnl+V5ln6iQpfwxVM4aLbOg5OTqDriQsBesmzIIgYarMmE76oM
 QgsRhUJ1ImTpyxnHUU2RJ0HPxv0+3VYO5K393k/Aq9gAT3hARq3kgQvCzbMpzzJ+kFeA
 db+d2cWHJ3UOfcYFybBWODdwPHVKUn0yL3m0y3iuPIuKa73DmTLkADWRkEJjVC/Ig8pW
 t6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787826720; x=1788431520;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2DBINuFMm58bjywl49w88Q8ntiTVwCXL5/JJ9jLbOUk=;
 b=p79M+AWiboOpdSXX41GxCmYes3L21WGzSru5CHjes3psLPZ9Laa2vXPak9L+348Wfj
 yzZkvWokroxj9NChR5IVGxfeLAhJyWB688dMIbPsLlE4Woq1lFmHqAk4LcRuYFXEZtk9
 IKZ4Io/5vP8mASMsnHeqVanRrXBIucl+ZTQ9Tf58c/F9WAmlICcX+lbOVVHbcqa85ZG4
 oBki44YmNxiw6DvdAJUnf+oVoMthscfsmbOhLgM2L+eZkfybZgyBYRmol3rDnwcUltZw
 sxVKhKqd/UOcAj/jL66qrbmnbdclUIEvwKotG9bjuEOUqZqFnE51RuDBWIZ+7oegP4UL
 Pupw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYIYY2qgyjk7Pc1GK7TeMWYCW59QuAEClkgj1oi6zCep/0Tk4quKUacPhwZ+aEpkqQJJeYIS2LPQKC@nongnu.org
X-Gm-Message-State: AFuF++m1dG4abbjGPl/6U/lXnjqoi5cPj84pSg+U+MCKaYeIZ5F1cI8h
 WPYJHuGe1uDdiXCH3xiXkHG2vx9+r/nbGaHlCTboUcFbCDc47mqB3L90ZZiXnTwkPcchY9mDZsj
 kcbT1fMxBHWF0zzMyZVufvrK7o1olrlvFdU1rIg0UDrfH5xu2Odt7woYmWQ==
X-Gm-Gg: AR+sD1115sDYbwe0Y6P5cVGeh33I3CVbrq2xMeG3rjUDwbUaf1Nks8xKsm1Lu3jOub2
 23swvgUku5Zc+gXpudqoGe7zWT6VwYSQQUUSQ/YYtH3t4BlcgW0Lyd/BlczXc04WNhkSNQKiQca
 b13UTQCJaqvwLYSpijrKWXJ01VxUFA4BRcxp9XPjcziWBJ3SOUDrkZWVJuMJjY/c8QYGQU6jPqr
 JYjSHs4H/NNPU8xR1e75Yox/QMXrj7Q0R1vhWz0rjTsbktwI4ljZ6uJUptqSd/5/p+fBaWSfmBi
 SIGSAB3RnQPHT3MqEdQg/fB8hJtxPC3f8W9Cz1jmANhXRkvl+L893Q7lnAPlj7ooL8h9NUK7ZFU
 L+XF/fJTkQxD13oF2k3aY1fHPScqYFAl2ww==
X-Received: by 2002:a05:622a:4291:b0:52d:9cfa:663c with SMTP id
 d75a77b69052e-52fa185dc9amr59596291cf.0.1787826720460; 
 Thu, 27 Aug 2026 03:32:00 -0700 (PDT)
X-Received: by 2002:a05:622a:4291:b0:52d:9cfa:663c with SMTP id
 d75a77b69052e-52fa185dc9amr59595761cf.0.1787826719892; 
 Thu, 27 Aug 2026 03:31:59 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f854dsm8106335f8f.36.2026.08.27.03.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 03:31:59 -0700 (PDT)
Message-ID: <53ce22e0-a26e-4641-ba20-0ae65b290bc7@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 12:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
Content-Language: en-US
To: Alistair <alistair@alistair23.me>, stephensportia@gmail.com,
 qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Troy Lee <leetroy@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-riscv@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <d88347aa69db68c498b593eabcd2377413ff4af5.camel@alistair23.me>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <d88347aa69db68c498b593eabcd2377413ff4af5.camel@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X6Bi7mTe c=1 sm=1 tr=0 ts=6a901221 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=t9496tuAAAAA:8 a=6o3zYDZGyaI6ylSOKDgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-ORIG-GUID: epoR1XuMtBPfzM9pnlLWPvFaxSBJSLp8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4NyBTYWx0ZWRfX8j+BvR8xRiKy
 3GOmlV44UTxJPqm3oAy53weyk5MxvjkVaVR6rU87cq4YLMa//8pMmg5CMixywknDfsJ443Ql4qw
 Nz8FzErER4tUu0aCvMGeyxPkFqIywRA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4NyBTYWx0ZWRfX7luDEzQ4zO8z
 4IblD92YpBj8ho2PPHHjdGXyJXzu6WdfGWOJeBn54E7f1V7CJP9qUTMDwayGv0PE3IMSNr6HtDn
 Y1kunP0DQd8d+EiSbEweDrw7opRwPyWNlgTmGOPBsuw2e303E8BF/iTUfwQ41M+9VFlymSii4dx
 UJwFtnkiKrRZ1v+a/514AbN0309IU+pDLmYEd8UDnlQDVqhRMgB9k4f2xD1DsSVNXkfVAGdG7iK
 saNjWVFco3B7SXtbHMo3G+mWvD/Nt48FCt2PsKkOe9cch1GG0uG3tqD/gzCr7wa+NFbtJsdp4Mm
 Y2tPum9Yi4tgU8HJBxjki01cItyiMFPCcIEtopt9nuSV0U+GJbXJoF/5wGzC68LC8ilJKJGY6gh
 Bs2lGV9hPs5IQSZtmL8f0LR1b/LMrnmlJfoamLVRxNDoV+wb9lB/4rxQdWW0cAdrpxrFu2lo6xs
 Tlvxu6XMOtO4VhlDkdQ==
X-Proofpoint-GUID: epoR1XuMtBPfzM9pnlLWPvFaxSBJSLp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270087
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

Hi Alistair,

On 27/8/26 07:37, Alistair wrote:
> On Tue, 2026-08-25 at 14:04 +1000, stephensportia@gmail.com wrote:
>> From: Portia Stephens <portias@oss.tenstorrent.com>
>>
>> The ssi_transfer function comments say that it takes a word varying
>> between 8-bits and 32-bits. ssi_transfer takes a 32-bit arg to
>> transfer
>> but there is no means to indicate the number of bits that should
>> actually be transferred. All child classes of SSI_PERIPHERAL class
>> have
>> transfer functions that, despite accepting a 32-bit tx, only transfer
>> a
>> single byte; m25p80_transfer8(), ssi_sd_transfer(),
>> ssd0323_transfer().
>>
>> The current implementation depends on the SSI model to know
>> what peripheral model will be attached and what transfer size it
>> expects which is error prone. If a SSI_PERIPHERAL model was written
>> that
>> accepted 32-bit transfers, it could not attach to any existing SSI
>> models.
>>
>> This change updates the the naming of ssi_transfer to ssi_transfer8,
>> as
>> well as changes the return value and transmit argument to be 8-bit.
>>
>> Most ssi models handle this correctly already, sending a single byte
>> at
>> a time. There are a few models that are written to support non 8-bit
>> transfers but there are no in-tree use cases that connect a
>> peripheral
>> to the SSI device. These have been updated to use 8-bit transfers.
>>
>> Portia Stephens (4):
>>    hw/ssi: Rename ssi_transfer to ssi_transfer8
>>    hw/ssi/pl022: Fix dropped upper bytes of ssi transfer
>>    hw/arm/strongarm: Fix dropped upper byte of ssi transfer
>>    hw/ssi/pnv_spi: Fix dropped upper bytes of ssi transfer
> 
> Thanks!
> 
> Applied to riscv-to-apply.next

Can you hold on before merging this please (or drop it from
your riscv queue)? I tagged this series to review but didn't
got a sufficient large enough slot to look at it.

In short, the reason I think this isn't the correct way to go
is SPI "words" can be any number of bits. While QEMU only
models 8-bit word devices, I have be working with 16-bit and
even 24-bit words ones, so I believe the current implementation
is right. I have be thinking of a better way to model this
granularity in our class hooks, but haven't find a good one yet.
Restricting some devices to 8-bit to simplify them move part
of the complexity to the host controller so I'm not sure it
is useful. I'll return with clearer comments when I get more
time.

Thanks,

Phil.

