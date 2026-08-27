Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCBEC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVfA-0001FF-KD; Thu, 27 Aug 2026 04:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVf9-0001Dn-43
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:40:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVf7-0006c0-6e
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:40:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6RA5v087847
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sQ50trFlPo5d532JdYVenY8HaFTmYzIbecwPOKivr/U=; b=IUs4rwdim/Mea8RA
 SzmrAM2qg09ynuk0KJGhht84Qgasz1eMrZkTPTIhpc6GuIToUs1k1WqPVHTxbkpC
 dngq8rn4zGlFI194CaK/rjItk/wN0JrqY8XrkNtb0ySr4yIxGdt8HCXf7gP7XSMB
 c7VqOrPISlcHMM5W0LUNvw2Zn0TsEfQlU0qallQTlktxdh4z4GxJdifkub/HgMl7
 ekeUCEu6qblZEVHvzmN0VQ30cuIiZFR+W9pDlvTAbzw0guSwn8FMbTE9fFa1fLbZ
 hZDYsX5t+/9Z0nQlSttF/gss8gmjdJ/metK32FMJm8e+64Lz9ykaTdXC4rHRJl0N
 2f1NCw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5hv6m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:40:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52f9e903b02so5274401cf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787820039; x=1788424839; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sQ50trFlPo5d532JdYVenY8HaFTmYzIbecwPOKivr/U=;
 b=BwIuHtdJCyVRpoTecFKJ0JKM4f9ejiaR8oWuPwZjqetina9iRaOApAq5d7kSH2MWCv
 xAcMNHwOp6GeTbllaPE39pz6xJVATnEzprPyoCIh6R0yka26VI7x2dDQOeOpk6COWOEC
 j4Esl52BoM0m8WHvsT+2bjRfTvpo+F9v8FulsE4UVN8GnmSwaThXj7Wvxk9Usn0ptxqq
 AplkAgrqXb+JiOqD30F/E878X5tc3VAqmqGfn1vfm2Jq90CRJEknY21MVUDwpxZ/+JGy
 mVS1o2x7CORs4qeEgP/LhMYSh5fVmwshp6JbxJzCxhUXyrNMZMGBdXNtjihCdfshYqho
 Kh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820039; x=1788424839;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sQ50trFlPo5d532JdYVenY8HaFTmYzIbecwPOKivr/U=;
 b=So0k5DoT5BlsKSIY5P9j1xe/AgYe1aU95YXYXM+Vvkojzsedm94wJMQ8T0dWmu+hSq
 CElNrUnDa2QpuKCr4zVH+yQ6GOhIFsb5ssHbxL94fUsZJ0NuqZLGC9VbDE7A7SXw3kU8
 NfrhyfcFM5DKCZv1ryRU+X5epaVLmwWPQWj2/JjEk1J4zT2NMpm52oS5vt9hBd5t4FAu
 htpNSN7G8hWic6GLGJmLz32Wo4BfFRP8PreEZFBYxI2zA+s3L7hI3Yl2gsyRwULiEdgF
 PoZuPxZOlIF3GOqi6OfIrf4mCUfJjgDYt8T68REnGV4XN6Y6s55jAuZaUD/PccQdo8yW
 MmOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RofMymWInd0dV0Eo5yc2JzqLOlecyz3ukFJBdfRSZAphZe5iEfg3cuW/6XwPXGilhx6sOrv9RO07CT5@nongnu.org
X-Gm-Message-State: AFuF++ltOM5VM99xbdVxEzW7vjLJWaiQ0O6dMsYdkUf7xAuc6QgAVbc1
 chjj05wSYwParAc8b7Dg/inUCojaTnMN3YZNM0qJQR0RbhaO1fSMBu6k/UmbgKMVrXAZjzHls17
 oJjtOpX0Gh9HFCh8aqAZ5xuDjiQrRbjxCmzX4eq8C4NLRkmOQiyNiZTtyXg==
X-Gm-Gg: AR+sD12t4KgdKmCW/b27DXOEDJ1L2kRPFWRx57FdgPLqFL51+HAgTKEe/FauZMaMA+h
 uZ/HTug0tQykoS/9BMVob1cQJcPSWkcqBVLVq60z/dv4aVwAzD6gyMWQBaJy5iKK2E1BW4s375K
 zCVNjq4eKgOSlgAL+zsy+fHnbQuZ3Ooj3o/7qtZfN6Q2RVIfq+gnXy1Jjluhy6QYYZxRzko7251
 S/1Ax38riBBO2caUN5oLEIgf9XOIo4+EiIg0jmvYnN/CbjxzaHVlq/DU804NeMROFcaGIHViRAp
 Pd86EgNxkw1K9tAZw88a3tG/14VTlOrdkqnNcD6Y91nnL2cpbmmPpwrVNerLxM10GPiBu1z7S01
 FIagPzmb1jbSXTUe5UUnkO7+751KC221dphDOY4z6whIVulx9
X-Received: by 2002:ac8:5950:0:b0:51b:fcc1:a0b7 with SMTP id
 d75a77b69052e-52fa1a99ecfmr41469141cf.8.1787820038714; 
 Thu, 27 Aug 2026 01:40:38 -0700 (PDT)
X-Received: by 2002:ac8:5950:0:b0:51b:fcc1:a0b7 with SMTP id
 d75a77b69052e-52fa1a99ecfmr41468881cf.8.1787820038289; 
 Thu, 27 Aug 2026 01:40:38 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28dc0d6sm7964052f8f.18.2026.08.27.01.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:40:37 -0700 (PDT)
Message-ID: <b62f7ab6-80d5-4e2d-b253-db6c1b5758b4@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/43] qapi: convert trivial intro sections for pci.json
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-26-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-26-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NvrBBxrSvFfVfxUBYlkzbbjvXhPQFWFa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX5Gg8+J7wf4Nc
 ftotqaKl768k0RQDCXhcrcittcJQNNWppgFr/s5pAljLZYS5rD3owmwjI8Xq4lbak1bYl3wMG9t
 Y75uQ35n0JadDhC3HGSa+i7vow3XeZo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX7YTf5iF7RLYp
 9TcWt+dfWRrCp3oQA7Clcvbf27bbUOhfxAWh6TLpFeaaoK+laDUdHDaLUra2a8UQVosLzDKcM8+
 ur/6cWeS6H+mcIpkD6TTFNa0vsS+Eh3NhvgcFM7C6Mm4ZFKnSFsSDO1qFrFvMAyIT9HCXFrsIUw
 JBE/hJYel80B9xEe7e7NR0ZAPvwJqLL42ajLGEMR4O4v4zJXDHRRt7CMH0vvMEVd1ZXJ7WVP4cJ
 SWozbWpNHROMFRl+DNdMYVMtXefssQ6AB+PiEQIeanVCJOzpD/RIMwGnAuB3zjwehbkGyBO6y6G
 gaNsPZNOVrupjXqKWg33/adCdNsuYrKMqXX5ChOTQD0WMi4eLFllCQCBR4tFaOnAY7yI9P6mF7+
 gODgkZ20DIDPIvS8SFLeNcOc4ispYybdavvcTUY6oRRxfn7CeH0u2Ji7sGMkEYAxhUslGPjI1yh
 aDvrI5Nt9I9B/D/Qu6g==
X-Proofpoint-GUID: NvrBBxrSvFfVfxUBYlkzbbjvXhPQFWFa
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a8ff807 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270070
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

On 26/8/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/pci.json | 27 +++++++++------------------
>   1 file changed, 9 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

