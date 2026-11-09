Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621F606A323
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CPX5gPLo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GXLA1oQ+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQI39-0003u3-Jh; Mon, 09 Nov 2026 00:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQI2w-0003Oy-6J
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:35:58 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQI2u-0006lE-KX
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:35:57 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93K5B03222730
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 05:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9TXSk/ViQ0WrpCR38BNImC8IUwFmaFgGQ8R4vjAksCY=; b=CPX5gPLoarWhLk0E
 IDvIfhkjBWc3CSMFyUCWpKFgwRI7dtp6Tud5kqKhMdNWpYFoLN956Ag/2f4Wa/Li
 y+7/b9GGjUrbeRHQF3opdUdUiRv4pXneB74nDDcoqXTGH2L/DORN4kA9P6nOtnpv
 kptVeP+MF0JzE6/c2o9syH95/VsrukGTxMDy7I05fHx5s8pmDnd/890O0OqyKYH5
 gNE3cLuZZ2dfAlK0aAqPK9LaUffXhMPQC2BsKrAUe/DVek3n4Lcb9IgmHTT+j5l8
 z7lHoNRabUI9PRZucdNb1+zB2UOsrFw/36cGscGyh+B+eODlwnIpFLulyNIhCBkT
 MrlELA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsv734rcw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:35:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36fa5673fccso2655177eec.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 21:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794202546; x=1794807346; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9TXSk/ViQ0WrpCR38BNImC8IUwFmaFgGQ8R4vjAksCY=;
 b=GXLA1oQ+DaOmhFviBqUO1ktlhuvaNqZU+v+cdvBbAJmlgmpQrt710if+PdLU1RiXwu
 JwFCLO9Xn7eR6p4yEHoPW/a1mxWcKXsZH+hBzxfxDFBYXhPgynyJi0TwUE+HdZZG+H1P
 sYa2hUt86UDR5dJ4NHNOj8lsmFNP7I9wasvWSm9IuomwdcGF1DfX30jYadOJ6cUFwG1i
 hpEPLVHYSSVrMBVPnm2bOacgOE4wjNDR1m6SIyIBdsJzh2p+Qmq1rqABJ1Qn/1tAVYDs
 MHovGxvaEMbOt+bTXaZPa1cUaW7S7FtBZmq//7Svf/mQBGpa5VTXRKLLU152IbakqaHC
 vdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794202546; x=1794807346;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9TXSk/ViQ0WrpCR38BNImC8IUwFmaFgGQ8R4vjAksCY=;
 b=dcguLwl+JGnn7QhpEfRQAsqrKDcM9+t5JtUWaoGcEZMVAVLU7pVKIpovKs7mfe6br+
 u+JCzZIQN4X9ARg1JgHHrVjy1RMoSkeIzd1GVi8k7xxwQ8y8xNmiUNZgZ78WIhc2T8JI
 E0MNRO/hCJD7S9dQlWiVzkm7wOcHArsUpcgS0179gM/8x/q18EprB27NPBuMR9WsiL9U
 5Bs4owmzoNlzZVeMQ07Vckdewh4lrV9m0mAvXufsbUpERwWZ5pBA3OytlqOb5ThuzgEZ
 kj2BF5X9pvZik68z/13YUS/ximPEVg8SvkOWK5iIlXy4nLxMjIfBajGf4DcgUkevfkCq
 TnMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHbnni7RtyWkoZPBSJhLLmMZ2rIpgPcXRSc4DbppoVbZqDFKm6GxIoMmE7GbRgC57o2hIOkVT+stG6K@nongnu.org
X-Gm-Message-State: APuU4Z9ymH9GGgsLSli+ZLrXLt3J5H54adHsXwQ/JCfno+35O3qP7Mrh
 kPpgsIV0uQrxF6BXQ0UsjimUU7xSJE0Tx4Cg9OVwRLSr7Y5pi4Q6ijthaFj2joVlv6wiljtEtNC
 enmkMShsD7OSGr47vk/+083eFnrRsRHxTfXSXNbTxC2NR9WKLs9ofTGSaOw==
X-Gm-Gg: AYBFou1KQdRfPQgiYDyJWLmVlVjc538owEYdIO+9pFa7nfkNmx9GZDjiSmszkPIYgqS
 BQRBQBeyfhzeRvuVFDY7jyp2Av4H9LgUfQ1zTQBcbR1FQYGoyNma27InS+Z3snyLyq9W5ve/6wj
 kbA62HrRFgyRsFn3msGyEc0XUbPJjceewM0djolR6N3GXQYdm7VE3gtIXCWBZyRaU97QYxji+uh
 qoEXtvVLB+cyuze2st3Vz7A9HpqDP7TOrLVoFGaInPmYSg7im5PWRvUFq6WF9nu5pCf0W0dkWFm
 Oq3oXpik+ikZ85a7xQMqsUJwV0TyrlJ2IWDn4QM/9KpwF1hIMytLjtVAJkumTkrek1METP1bChR
 E2ISLwU5CBccUG5/rurHOohPVZ1ArR4vC2k3kDIJ6l+spTtshT5EJbpWVfJ32905RftycYq/iaF
 WXGEbAzx4M7osvzl+QhfWeNzsRjU0ZoZuLoamHHntH5g==
X-Received: by 2002:a05:7300:e9cc:20b0:36a:22c8:ac57 with SMTP id
 5a478bee46e88-3725e91fc4cmr6259025eec.33.1794202545554; 
 Sun, 08 Nov 2026 21:35:45 -0800 (PST)
X-Received: by 2002:a05:7300:e9cc:20b0:36a:22c8:ac57 with SMTP id
 5a478bee46e88-3725e91fc4cmr6258983eec.33.1794202544936; 
 Sun, 08 Nov 2026 21:35:44 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37265a16f9csm10478111eec.12.2026.11.08.21.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 21:35:44 -0800 (PST)
Message-ID: <1406962e-b959-4cbf-b051-aaa759db3bcd@oss.qualcomm.com>
Date: Sun, 8 Nov 2026 21:35:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] docs/system/hexagon: document boot interfaces
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
 <20261109042307.1301438-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261109042307.1301438-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyMiBTYWx0ZWRfX93hnq15Ximse
 LD7nPafavb/M3LCASw59m2GQTK5ksBJksGeqcHqrVj7rHoaLkKZcWzlkrB6xPPQeRuxzc3HVdVy
 HLGu9jqoRgs6pkx4/Bqetcsy2ek1ks/u/0DG/a5/UJNUyW/AqTzFjBBHBnkeF6t2x8CcCIWAIO5
 aNKLSARSsdIcVewtsvF56aSu1QneDwf/MFQhxFlQ/7h2SkUehXThdOVBVaxidv5/EUDalhwlefS
 Cyp0n5RwBA/jPiVmjTOw8J7dCkVjuayxINt6lmzT41bMFgMlteKbJn+Y1kQqCysMfXmSmC/iLs2
 yvhxusMU1OIkkHru7UflgGkp3kGPEECvuF9u156Ih6wjAseK0GprlE2gAddwtfTfmiPup7FIjcO
 YkFfP4Jw4HfZGWFwvEocQObUCufs1Qz7B7hNL/5zh3aQMsu5/MISwuJldSCrfh9uXxNxzy2Tc3E
 Z6Kse4N7GxuBFT66sUg==
X-Proofpoint-ORIG-GUID: UjAn0ONDg8kM7P3zkDCO86_HzseFsNRW
X-Authority-Analysis: v=2.4 cv=bcb+w+PB c=1 sm=1 tr=0 ts=6af15bb2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ViZwloAHDpj0P8j-gm8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyMiBTYWx0ZWRfXwqCpmanA9Xe3
 dS7unj5NXrawXjOY6yJYpbgGA49AprNvh3+fk6A72qeMRm3zEPebRxcDWcynLHyjPDCE7CSfLCs
 CdIrh3fCHNUX2WWxN+227w7Vz47zOgM=
X-Proofpoint-GUID: UjAn0ONDg8kM7P3zkDCO86_HzseFsNRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090022
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 11/8/2026 8:23 PM, Brian Cain wrote:
> Describe ELF and raw-image loading, reset state, the DTB handoff to VM
> host firmware, and initial thread state. Explain UART and semihosting
> console routing.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/boot.rst   | 100 +++++++++++++++++++++++++++++++++
>  docs/system/target-hexagon.rst |   1 +
>  2 files changed, 101 insertions(+)
>  create mode 100644 docs/system/hexagon/boot.rst
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

