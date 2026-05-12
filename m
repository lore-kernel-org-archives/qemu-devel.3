Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE02ECD484C
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMcoV-0008Mj-BL; Mon, 11 May 2026 22:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMcoQ-0008JL-NG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:25:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMcoP-0007VX-9W
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:25:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6isC866468
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eRJ4BRbAd2XyfGLm/qKlGW/bJTvOG1/XHwUZ1/6uZu4=; b=QhNLeOe6KBKjKC0s
 4xvZHjZg3AUQzSD3hgrmPAvgtCxsPULildFUpJN652Fg7UTek/5PdT2Tz5XJup0w
 BARe4fQO3DJi40jh9P6SPDX+xF6v3AkWd2nZqkbDDcC3LvzuYjhq6q1uD3iRJE26
 Iy0XDr6qUKho2SdjfZqhqq43p65Gufc7wltYbs39TTzCnrPYCAeCOA6fldERamoT
 1evi7XuAPrE0G3EFV0Q3Em4Wp93HrdmKR1zib9+u7DhvE8GwR0r0e+7lYydPlGew
 hNjaCjvlHZRxURTCkrRz4UMuBisy8QkTYZtfx1yPaOGt5kwJ+LbkNG5KlHUhXAHd
 SjviDQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv28vwv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:25:32 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12dc3d81736so4610889c88.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 19:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778552731; x=1779157531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eRJ4BRbAd2XyfGLm/qKlGW/bJTvOG1/XHwUZ1/6uZu4=;
 b=gu2YbICph3cwutY/sNlhmbAPRT9pZEKxDr64bmSFQhSc+Lp0nOxcfjFrpid4rpMda6
 dfOmFsd5U+IxP8KIc1k1tUfv2hH0rYfQl6g5kjbvGEphF4DFxrkbJd+5yAnGwnzHxYpj
 fXh2Z5t46UIQdJtRF2azW7CoUgDB/HHt4lPKJ7AQx6EQJpr+dOqgw0xhy+IEmsMKclfT
 iXt8rg6/NaBA55Nf4+6WmtON9TbPpTfOurW+l2uO4oCGne8XJPKo2YkaWoGrE0/RILL4
 DCiH0xABHF1mLrqbodKf50C3Y7eN8Jpf4uykCtM2GWvtcADd2otpfhji+Qfg5h7c0puU
 BhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778552731; x=1779157531;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eRJ4BRbAd2XyfGLm/qKlGW/bJTvOG1/XHwUZ1/6uZu4=;
 b=VE0dwwhwwVbNfWINs2LxSNoqQH9fJfA6q+SL5C2fFv9CAsxdmQMNC7hYwmlJKHxgxf
 r7buBE4Ubkd8WOd7+8dcud9Lryda0X85ojN5SnDaaY4c83KmWIh9XervPJnNY+CbcdHk
 Q4fivSVlODdEUOYVB4K71NNJdqH+PHtWH1tsjGe3wkEXBgj9esuQhqnXJhKUbZ6Fnj8R
 DGxQMAyNgl8Hq4pnc44ZjhZR4JQmT2VDTyzPIZL/c6qvL9LdXVz1ziZj3jbNWe1w57wr
 ex4ytSv/BOW1yD3+Bkvmw41Yu5KLs6R745oKP/SicV3aN/cLdbT+cOvSA6zeeZ3bkjiB
 i9kw==
X-Forwarded-Encrypted: i=1;
 AFNElJ85DiJP+gLFF63Mn4R2lfkTBlDrjYCzT+mOPAqGVqGKy2OKZW9GJDqdQFI8WqRgoPcX4TzCE3caJfE6@nongnu.org
X-Gm-Message-State: AOJu0YxgTckFjMK0zYas6FIk4wmo5E3Oqqx2GCbxDmf2EnU7BvzjLQiG
 S7Mb+uc7ei4tO71lsvLevuOzdYkVLUq2aor0GWJjySPXcJ49hN/qIuR41GJ+kmWT41TTUMLsam8
 V8f8gV07NWr2ihleiOmap/ecbprRUZbhIW/dbYDV2FN5HqbfNsAB9lqIZKA==
X-Gm-Gg: Acq92OHxPbneEMAKIkJ/rYvSHxIBrG+ohN1IyHe6rv2eaxTslFyN5jwStWrhIkza37J
 fsVPy8grNeonBu3gdasiclRuNsCVMfIOD7Kfnxea3MQamA2DCTf8/6ty6REQaX2T2KI9KDaF+QK
 8X2PBDbeZMO6dWtrZD0bXUjFzHJasSLTzMG/0giBTx5TVPJA84ENWFRIlHLrdxxfqPwAaB8NcUh
 gVN/iQT9mCq0PYD+joNCAYQvAXpL4GnmzRVJ89fnSKImRIURCJl7u0uAAwXmyQN9s4hdMs9NSUD
 ewIvJA0/DFDNg/Te7PEAwcq34EKwXOhnQAqG1lrkdu4sbKztfG1F08Qbp4wAbncqADE5rzYGZTE
 q/N/M1sowlFXl9LKRlDlVtm/ulgA7VLrJecAmZIj2SaEwOFMwReRiqKDsuIPtz72xQwLcp2PZzJ
 kNiomWUEj1iwqyHw==
X-Received: by 2002:a05:7022:e19:b0:12c:61fe:fb49 with SMTP id
 a92af1059eb24-131967d7c1cmr13814022c88.6.1778552730965; 
 Mon, 11 May 2026 19:25:30 -0700 (PDT)
X-Received: by 2002:a05:7022:e19:b0:12c:61fe:fb49 with SMTP id
 a92af1059eb24-131967d7c1cmr13814004c88.6.1778552730443; 
 Mon, 11 May 2026 19:25:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132781103e7sm20675642c88.1.2026.05.11.19.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 19:25:29 -0700 (PDT)
Message-ID: <20349be2-d34c-4907-9d7f-7b88acabb255@oss.qualcomm.com>
Date: Mon, 11 May 2026 19:25:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target-info: Merge target-info-qapi.h into
 target-info.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20260511190634.472174-1-richard.henderson@linaro.org>
 <20260511190634.472174-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511190634.472174-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mtPioio9ah67YnNome4DUuN2ORe0SAUB
X-Authority-Analysis: v=2.4 cv=Mv9iLWae c=1 sm=1 tr=0 ts=6a028f9c cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=uHEybWVnMX_Sh_iNFq4A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mtPioio9ah67YnNome4DUuN2ORe0SAUB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyMCBTYWx0ZWRfX0zkHUhILu5Oa
 0nDp4GAB1UG11EUZ3OZpQtmpKw233RQsEQbTCmeseXGqG6nXKpa4oaLIFgSe7ig9nK4r0rm/V/5
 P2MObyUx4Xsotbr94AcEC8DGDHaDFr4v5hvPP6QAIqTaJWSE7L/WfpryePaXOsqO7wYP+IQcnj6
 Aui/vtXCzgPzixJrEtjnYISeq1nnH3t+Pko1laHo9ZaHEP9JxP6xz6D34x83yMiqQbdyFe9WHbv
 Is2vyGYWQHzPHcGXEV00HMCpeBbYZPkTRZN710XOoARTvPqUTMwohoeXuxUU6M3mZ+af/GcQImH
 9nJkmSUgbECvdwZFxOFtU9SRUViBl6K9iOFV0pjPEZ5MA4mFWgrHJF2Y0c7hnAebelqI4em4FLm
 oU7zZTAVolOqYIoKRnjza13YAdLk7Dcn2rbfjk5oXUrGflwZZ1suy5vUy1LWRFBi7wf2kss85Ac
 gpCFPkzs5LKW9VywV9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120020
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

On 5/11/2026 12:06 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/target-info-qapi.h | 29 -----------------------------
>  include/qemu/target-info.h      | 14 ++++++++++++++
>  hw/core/machine-qmp-cmds.c      |  1 -
>  hw/uefi/ovmf-log.c              |  2 +-
>  hw/virtio/virtio-mem.c          |  2 +-
>  system/arch_init.c              |  2 +-
>  target-info.c                   |  1 -
>  7 files changed, 17 insertions(+), 34 deletions(-)
>  delete mode 100644 include/qemu/target-info-qapi.h
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

