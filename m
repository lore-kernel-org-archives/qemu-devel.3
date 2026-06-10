Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169AACD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXH7j-0003A4-99; Wed, 10 Jun 2026 07:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXH7i-00039X-6h
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:29:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXH7g-0007aF-24
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:29:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ABNgur3658111
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uJpcZhLQl4fnlrQI3ykh7EKN8qsHXibmIORY8RY4aQE=; b=bCWBoIVVK/2AJ2dw
 QV6gUtkRDtkn/ezB0cVlzAWyWHKWJS5eumPomrbq+tqVNr1+2KSbgXGB+pP0hOWn
 Z7rhCnetIQMp0ZfscnhSwpspa3tZLezR2K9vkRmAk3kGPMb8viRFRTycNVR+hnpX
 rDVLwSFMZnrEj67ZkgD/LuSpWOH/fdsVqSV9Ry7oVkvGRNmv3TWbNQXryKnYcu3d
 3WEZsiNOdM3TFSezeYAzb03+NAON5VyGeboUlaLud3GMCGIFMbTXwXqEWzGgr02K
 oLtZHfhg6auE52BohNXpxO1FbsffyYGpIBH8gcqD9WHthHhwv0jJrfFmuL+RBO1x
 13TE4g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnet7ut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:29:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cea4854fe3so134892156d6.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781090965; x=1781695765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uJpcZhLQl4fnlrQI3ykh7EKN8qsHXibmIORY8RY4aQE=;
 b=jL15twagLhTrTw+UlqdWHPg/vBONN++jAXApa7LZD+OnolGSnOlOVovlkZErv398Vr
 suk+AlaxMUmFI7m+iAfdkelEwbG1nc1HxnjSciU1PIlNHv0FyQvEIDKUKBffAdkM0kBC
 hrE4qL8iLQBCU57Cj8bAzEQezeyKBvdrMQiwEDtuV/sGIYycre0VKgGp/Oh2gFOcLeO7
 UF/PkxadIxU2mh8iT/poFYzuU5YomwbP0c7Z7gLhg+QqjgzN/EJcgyaGtckJp4ildsYk
 ILLM71oRzszYT46sFwcWF/iMY+B491fGlmSx3cWj1Rh1L92rS4wWnpccteiW3ShY9sui
 AmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781090965; x=1781695765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uJpcZhLQl4fnlrQI3ykh7EKN8qsHXibmIORY8RY4aQE=;
 b=PjY97ien8aqD2YKJlRLC5SzP5YRhgTRjjCtnWgg0akC5Q1Qdw2lmCMAJkP7FwtuUDi
 aexbhAxzoq0DaTGCQRXIMKn79IYJ8vLbh2+qqI7ScIqyTuPwzGWZwZS8c8jcVD4MDnrU
 qXOD3D6H4tCG8oI0nDGmMm6V4/DJTlwl2dZU8sepOBrF+PYaZdWmItgqfSZEDiEcg4Nh
 XLbjF6CWwny5EMOBQ360gcIgX0cdPirysHQURdqsFZemNlnHhf6HJqR8xSfWLOn2sX2P
 HhxheoNf/Ti1dWjzC15V2bjoim1+tXNFPFPwQyM26jEWyLGqteq7LlMlKUmiL/Ky/FCi
 Putg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5dIxOSldpO0BQ28Uip/w3BLSk0GL5TdjFSHzoDbHLzkGLSzl6oTMMgcAyywkxdTyHamq4XDmnyMRU@nongnu.org
X-Gm-Message-State: AOJu0YyuZu/C8Q65SVXnJThZ26ZRP8VhdHZoxPXIqJKJ/BMNKcUKPXB6
 mfipyFul//wr7h8xiANr1AF7be4BPNt++0L59z4TT5uEj+Cg7mHD5GL/1xPVVfEQzNp7z6Y4w6A
 f3U6IYN9J2VejHgogbrbhL4zcLalAqp4yUb9GCmlZW1hYVaJz/HmeWGPlYQ==
X-Gm-Gg: Acq92OFKCMwxOIidnKK/LrYiU7gQRsJKSmpjYK4kHrrtXzT+Xo4SW+Ymu4NpcI3XCbr
 PmDNq6So62zEyEyhqecQzXAWRdXKcKdLoawl/fEbK70XFnHBa0t/sa/ontiWddwG1gDYkMDF48s
 r7isC77EICwRN0F3x9+cwwb8xY6ElOoiovRCn7MJ38KaRtQEfrwT1YeBuS+sAn48mdFnt3+kI1t
 qklU0EQ55ZsDMR9lkJCLY0H/UFcvI5uArzNYijAv0sJ5drPy/IBc2IoTmRR108FLRFC9FyYS8Sl
 l8WVKuei3AtQHVUeLcOXBiiKlY97pst2HscWbswSkYZnVPUszOwdb+NycruphmklajP9UG+9vvS
 OPwJyCHb78p1wGXDl75JfTIbB5oMxlrl7+KDDArgGZZVrBi/+QvNh87qBFb7UoCHwY82mYxMRk3
 fIH/E=
X-Received: by 2002:a05:622a:558f:b0:517:b750:628 with SMTP id
 d75a77b69052e-517b7500a63mr198648341cf.45.1781090965185; 
 Wed, 10 Jun 2026 04:29:25 -0700 (PDT)
X-Received: by 2002:a05:622a:558f:b0:517:b750:628 with SMTP id
 d75a77b69052e-517b7500a63mr198647311cf.45.1781090964268; 
 Wed, 10 Jun 2026 04:29:24 -0700 (PDT)
Received: from [10.156.84.244] (49.170.88.92.rev.sfr.net. [92.88.170.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0517714c5sm1189192066b.2.2026.06.10.04.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 04:29:23 -0700 (PDT)
Message-ID: <b5d9527d-9295-46c0-9259-31fe7323f1b5@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 13:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/22] ui: move LED and key utilities to input.c,
 delete input-legacy.c
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-5-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-5-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LKoeeV_SmRzoIcXlpedHo1z8KBEEeh0Y
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a294a96 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=YLXAUxGLE6hMr2F5uSHVqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: LKoeeV_SmRzoIcXlpedHo1z8KBEEeh0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwOSBTYWx0ZWRfX2PwHDFkLO9lk
 ppcs/ci01KVB5LAsCukpc1mcLA0PS8uvRlSWlBnSQw4WlAyJ36BqqhlgzjKbObbyoI4SuU0usp3
 4TyfZX8AJyuQt3de1qBjBB5b3Q/hSrkIm79ZO15RR843DqO39NiHxnffyy2axxyukx90ux7+4rD
 WnwTNAPyPQY5jv21zDPfNllhjdUYsyYbRBWOyqPS44lpNmuAvgMHPKS3cUmNhQ39WmPsc+DO9sj
 wcz3h5mdhf+E0pmKS9xV+jYxxic9R+PtszeSsUN2T5Tx/WgWxxhXhgE5SwBMeIz8cBBcrewDLp3
 fYv8ERT9SqWmrE8RNE+/vgJdqGiZuZq4Uuxe82UDA3EHbQjNAL49RXXXCGq8sS40PtQD+7N12sF
 SoBn2/kZSM8IoolmU8/BFqJuVTxBiruqvrPMWEQB2h3tsa8V2DYr1bT6nz7LXdYb8h5cMneC69a
 ddflJYLgqIgiSd/T8ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100109
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

On 10/6/26 12:56, Marc-André Lureau wrote:
> With both legacy mouse API consumers converted, the remaining
> code in input-legacy.c (LED broadcast, index_from_key, qmp_send_key)
> is not legacy-specific. Move it to ui/input.c and delete the file.
> 
> Clean up include/ui/console.h by removing the now-unused legacy
> mouse API declarations (QEMUPutMouseEvent, QEMUPutMouseEntry,
> QEMUPutKBDEvent, QEMUPutKbdEntry) and MOUSE_EVENT_* constants.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h |  18 -----
>   ui/input-legacy.c    | 221 ---------------------------------------------------
>   ui/input.c           |  66 +++++++++++++++
>   ui/ui-hmp-cmds.c     |   7 +-
>   ui/meson.build       |   1 -
>   5 files changed, 70 insertions(+), 243 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

