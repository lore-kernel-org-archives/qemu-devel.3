Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9680C56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1Bj-00028B-TD; Thu, 06 Aug 2026 12:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1ws1Bi-00027o-TM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:43:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1ws1Bh-0001DX-0W
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:43:22 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676GcQ8x2522959
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 16:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P5UAiClaOl9hSKZiZNp1j8NNahD1tlt7xr2vevJRaBs=; b=WbsyxHXugG+Tj5t6
 ultxTP64M9h1jDvRjkjF56gkZY3dxbN0rPmO3MsoKUf1bEyFIH2m0hLM6PLAofRN
 bxN0LydTgqJWE4JKJ2cpxgwdhLWhaEaMQ2is1Am4ZcKrF4kSIZl3iZ53VD2YXcIH
 ydgXEIA0coO1uk13yLZDw0wA+IxRYgHMCuQZVfpoAhVarNaqmyUoQNXPzWVm2/0a
 WmH4dzhHqpsQK+6tobxhxJl1JRBd/Z+eXmFjBat0Y4ezxebQnZV7zclxb4g9Thx3
 UINMgIXjUYthQFkLrFPtte44iXCSrGQKFQe2ZFc1316OVnHxI8rutCjsGpG5nYQv
 xaD8dg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvwyfg1gs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 16:43:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso3962736a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786034598; x=1786639398; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P5UAiClaOl9hSKZiZNp1j8NNahD1tlt7xr2vevJRaBs=;
 b=htcSvuwPfzp8L6P2TkVJB43naeNDyQeTuP8cCEPSMD5YsB3OPeOS1en1VBUI60kslT
 YJ5NYUvZHGTRdyhrrpIXUWaKdfT8IBy6U6WHXRNPS1rKlrKSfxH3OoluSB+PkOrQMB+2
 vMLIqulNXEEUPtRXwmlFZaXB+dYMPEC9ulvbFb833E6bkyCpLcAAVOR7IAyMA5hDSfRN
 Gt8iQMwfAjwpeoi3dktGGKOw2b/QANa4qXgHEDEdIuC822UpQ67HXsnwi56fCIAVqF31
 BQtrv7hm7tthsIycBWZErXFsI2+0QCjCz6PNbMfaH89CdFpHpHZzACFFmnw1Zyom4HXe
 tFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786034598; x=1786639398;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P5UAiClaOl9hSKZiZNp1j8NNahD1tlt7xr2vevJRaBs=;
 b=CVwXAyP+DVbsmHjFhS9nRIOsa71ISJEDlbZQrXyemvcYoPOBho3UipZaDyPGJPIfgU
 c2iIuWDZW3aAtbXPU67dnjeCseZiMwiF/jm+YsX6sdImihxcXByUoh2aQVFPdNUwFkZJ
 y3wMixFJT4FTyswOxmsP9OnRjD100ub+B1Z7XFP4nvRXmjKwPBizWzKL/Y/gwL8LprHA
 O3Fthcwo7y2za6s/FfPWQ2IshxNCEhCucnhzRb74pcplDQUZxV8o3yjJwGCvj7f19NGq
 QPDuTBPkfLT5ptnXP6S/tmDCd6fhV150h7RKXRROc21wow/BfgqkPjRGHZ2xRPmf9XnG
 uJeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnVFHFj45b0jiPDLpRnkDijASj7FXWJsK9/u3ip8niyjv5zVA4rcmQe7fdpghAehEFeDtYfq7XLGPv@nongnu.org
X-Gm-Message-State: AOJu0YwhcS0UqHvftYi5Y1geNlZG7KLT0Ds7bCF5vkGc12NvUU1V+eo0
 8HHLhz5Sxrm51/tvyIzn0ttBz40UfzIiKq52UE19GqI2s//7YKI8w2HmQ2sOYf7T6iVDnYWvl08
 JtjA4Xn1mU4YIwYRiOIoce/NyoeDIRU9Sr5fqNbVIxnw1jqagC8I1/eQ6sg==
X-Gm-Gg: AR+sD11aEfseS+EH9sBov+AAsjZ5vRpwFlqdg5Nkd3cJSYNoydCcVT316d1V6xuN9vX
 GpMO95GeybO6Z3r1GMtOFe4SymNqx2dZrOrf347LNazm1RGmcL1qEyuzxpu+7UatqOFqAYDcDBx
 g/QfqIYgvCZjfyq0vxxvTiojkXYtU7aFcRlvLHX9G/rI3LpmisPbcIgR46gKUEAXOoFkYvP5xEj
 XAJMURkV0TAM1mo3+eqRIwPvr0b/S4U2nFzU9fGpXf8Kz6ct3UNTYdX8/1UuCJ5nzeQe8Fpr2bQ
 sFilhVrQjxuvDmv0nSrsMk7v+J5wfSBy+pynQSERy6xv7yZFji2Q4P7IezlPbhtb1ug0d9xveCI
 IKEUhJ7+uRpqHHd/lrYFVtx6DunZLhUGwvX+H8XFaR3Bj/Aayv9yDWhwuEab23estCk3c
X-Received: by 2002:a17:90b:5111:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-3903c633720mr18000195a91.20.1786034598345; 
 Thu, 06 Aug 2026 09:43:18 -0700 (PDT)
X-Received: by 2002:a17:90b:5111:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-3903c633720mr18000101a91.20.1786034597824; 
 Thu, 06 Aug 2026 09:43:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-140f744adb2sm13191744c88.2.2026.08.06.09.43.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 09:43:17 -0700 (PDT)
Message-ID: <d5a42af3-d7d3-4869-8ff8-a971cd6e66b1@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 09:43:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/18] hw/timer: Add QCT QTimer device model
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Damien Hedde <damien.hedde@greensocs.com>,
 =?UTF-8?Q?Tobias_R=C3=B6hmel?= <quic_trohmel@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>,
 Thomas Marceron <tmarcero@qti.qualcomm.com>,
 Mahmoud Kamel <mkamel@qti.qualcomm.com>
References: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
 <20260806042723.3785369-16-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260806042723.3785369-16-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MtLKj_Hfz4cA4dJhy81qh7oMcHo-u4mk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyOSBTYWx0ZWRfXxhNn+uSn581Y
 DR1ap0yjz8+sRXLUecQbvElIx+BD0FCmSSpk+R3nk5t9ZDYipvVmbhW30QNPzn5J3KOg4rnksXM
 KSd5UI1toSJtuDwEXobTL5tNdh21XQ7lanOLkbVzzKaswKxy/6vGpnoHkEZmBst0DnRPtG2SgCX
 UvuxxvjdDZ6XgpzG9dz6hd3k40ubUOkYYAhh1Yw6VGlg5BBsgq+hUl5FK58kIFx8EPTtmRaVklK
 vpTz+WhaKrkcDIO4659/LSm5cV6NaxQewQ6H5Itg18jC8GTJ4rFVIb0jZAZ0DopfqMaHK9K8E5V
 nBHpufK4rZM/LhMxyocsstGfgn10GxuuFRSb8qK7YnAPvY6xYNZDU51oHbBgTbo77fWO5L335NW
 y7UGcVQvG6VC/OrKH9vSFS/pkt7LnPOZ62rpXkpSiRiZuZFmfgvgv2CzPWbWiwyeBOHXvA9NuN2
 u/9VgR++GiYTbtNV2aA==
X-Proofpoint-GUID: MtLKj_Hfz4cA4dJhy81qh7oMcHo-u4mk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyOSBTYWx0ZWRfX2O43buOR5scp
 iY7+hShxKqKiU8Lb9lEOjGO9TlBW+O1AUZ9DNgpDqiDM6eT3lm3N70gwrFkFh0nC6bfiCO3pEBH
 XJGb0HksMjAOutaEuEdJ5oJ9sWEzmwI=
X-Authority-Analysis: v=2.4 cv=ePsjSnp1 c=1 sm=1 tr=0 ts=6a74b9a7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=1cGLs3X8AAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xZvI-wIEd3Et4Z0emOoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=d8ghUycwObenwynNfMyN:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060129
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

On 8/5/2026 9:27 PM, Brian Cain wrote:
> Implement the QCT QTimer generic timer device used by Hexagon DSP
> systems.
> 
> Co-authored-by: Damien Hedde <damien.hedde@greensocs.com>
> Co-authored-by: Tobias Röhmel <quic_trohmel@quicinc.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Co-authored-by: Thomas Marceron <tmarcero@qti.qualcomm.com>
> Co-authored-by: Mahmoud Kamel <mkamel@qti.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                   |   2 +
>  include/hw/timer/qct-qtimer.h |  43 +++
>  hw/timer/qct-qtimer.c         | 667 ++++++++++++++++++++++++++++++++++
>  hw/timer/Kconfig              |   3 +
>  hw/timer/meson.build          |   2 +
>  hw/timer/trace-events         |   5 +
>  6 files changed, 722 insertions(+)
>  create mode 100644 include/hw/timer/qct-qtimer.h
>  create mode 100644 hw/timer/qct-qtimer.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

