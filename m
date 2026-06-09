Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37020CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWy9l-0004Ty-R7; Tue, 09 Jun 2026 11:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWy9k-0004Tl-NT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:14:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWy9j-0004Gm-Dr
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:14:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659CnIJ52668346
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 15:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DwAs7tV6HakGD/JxJIZeuOkbzpPUTm51yC6UYGCHolk=; b=dedBksMjHSIWdNb8
 vwC1ILAKhwmBx7RMEfmd6ezVeSQnXYYVSpi495HJxVcr+1H1+wx0PXLySUfA+TQy
 IJGaaFuiTj55PwMjM+YNC+aBucr0ECDUrHfyyoBbYOS9r0y1LZkrJ7wlF6hGdu0O
 hU9/mm7zjX6GVctUgmWZ/9Fi0sbmCtG9hxFzCsTrQzZ1fY5s/LTvONWCmepaxSqG
 mGWe4oanz0i72iNM/oYvN/AeKFzZJ7CM+NnBqE7EnhDGhm65PzkfLTuUP/vwX0xW
 bhsAOANq6MYqirSHEpOt+tI8hw8IQNsLqZ4K/e+DsZcbzTlK/P5hLEbTxeekoubG
 CYVruA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25t88t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 15:14:18 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-96387f0ca7bso1930750241.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781018058; x=1781622858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DwAs7tV6HakGD/JxJIZeuOkbzpPUTm51yC6UYGCHolk=;
 b=gXJD1l7zc5GrIOVNcKk6rtkqyUAQBFAthn+v30RlIbNmP4FJjPPwxovqODBnvwUopu
 8tWr7GKEIevRIWUcAij5HVqdfMTXcm3wv4SPcC6ahpjyHVPGSjhGIENnXzM8oaxCamaM
 yqW0/1CQoLTHFPmUF+NyHTa2OEyxO5euvL2KanHmzjTvAtVKrdLW8BbJ3N0Qxf2cL5I0
 RNR4DsAa7iytumTFh2tRvNLZRA1NiPCPBsuFlhRwDxmlTmp3/PgVd7igvPJ3ZxzOFHdU
 n4WC1iLXsMG9IoyoOmpRCKVE+a2/emmlcKQVRYeRFEE2kguIrzPaCMXRvOZgYSiiS34E
 l5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781018058; x=1781622858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DwAs7tV6HakGD/JxJIZeuOkbzpPUTm51yC6UYGCHolk=;
 b=oCM/CRTORdTYKoEqDIRzhOCSybn6x5Ukwi5dRknkg2J+jaM5kSjE1O+FI6bsfmP7S+
 ftSyqVBPfvU6bONj68QxN1LcjbGvjrlVayOaB/AAke4+UuKpkRwqmIc7rJRhiQBaJ3Zb
 EjWaHgaNN2OWm3osC0GSvE6mXatJyMgJDfXQUmPPO5F6boNBnuPy01lVpzeHOWzCXAge
 Fz01FHO7c3eBiIgGeUxOGcVV1GEacltqVypGztg63BiwZbwZyS1QsaPieInW/lWSx5Pp
 UKUX9gAi9o4QIe7YVVrOqAcbf2wKgTrHebBJQaZ1QxbCD13oFQ1JbcSu5+bIR8HE+e2y
 ieJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NGAz8AkbSszgbHSpdlJRFI4fOgYcTn/ctt2zIpaP+IBAmMhvu+c12HZGhgchfdyavTj73ETtxX2Nl@nongnu.org
X-Gm-Message-State: AOJu0YxDxQ6dlXMhssFUE5fw6TJ5Tdygtv6x2alE1dfrSZX0BMXENv6k
 HSvmx31ldrxmJ4hV+erAvNbJ4+40A2GAGRa+vINNfV737R+nsCWWmsojyIaNASuI7ZzqvnBh+Ui
 skyvwnpXSyHthD/Eeh4mMSX5lxr68nGCvuXjYbFi9P3tjqzk1iV13mlEtsQ==
X-Gm-Gg: Acq92OE9M2RJHLpArqhp6hX3sH1GnkLgUWj6Sx87AqA7vzKqw0l3xxxQkNoA3UWi2un
 Vhubu2OhCJ0wY49+Kvm62l3sAlnoLgXpMajKgbfduCtzE3e8Too1Ctu6mVt3PrgTr2XqIIkoNEj
 uXk/GDRv7UwrcJc7jXCO/qgA8AmpReevkA+ARU4gY4dW6fBr+RJR/Yh5NwuNdfrr7j/Lvn5wDqE
 JXjTrBuGx98CwAtAlMVfIGozjCHyUAvMuQcPjlt2nvZPpqYsReDiagvWcNCH70LhSlc2XcTYaV4
 AvSVoL+uflbWcJCRYYMwldhj8GkkjOcGo2kjqf++c+yW3CZPEOCDxVI6FUHUgaQRXV00yPVgwCB
 Ez5SE5X4ZQIQLfPsOZ5D/SQaTZpcAuKzaCNJAWc9RrvaKmkAjjfpfT2vv0wJAHtswph4=
X-Received: by 2002:a05:6102:5986:b0:60a:8515:9097 with SMTP id
 ada2fe7eead31-71928c9aa40mr1843731137.3.1781018057502; 
 Tue, 09 Jun 2026 08:14:17 -0700 (PDT)
X-Received: by 2002:a05:6102:5986:b0:60a:8515:9097 with SMTP id
 ada2fe7eead31-71928c9aa40mr1843676137.3.1781018057095; 
 Tue, 09 Jun 2026 08:14:17 -0700 (PDT)
Received: from [10.156.84.244] (113.170.88.92.rev.sfr.net. [92.88.170.113])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65c542c7sm9190390a12.31.2026.06.09.08.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 08:14:16 -0700 (PDT)
Message-ID: <ce1fb3a2-188d-4b3f-b900-0dc16e860bfb@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 17:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] hw/input: replace fprint with LOG_GUEST_ERROR
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
 <20260609-ui-input-v1-6-42615deb818e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260609-ui-input-v1-6-42615deb818e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pvOVCACy9nSbQfAQ-49beYDIDkk02f2a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NSBTYWx0ZWRfX/ZPCGxzq9cPW
 B9pq1auaYlC9SgKQ61hmH1kW2fpWdF9kUhPl+Y+rM1vS9zbpXxLlpFX9flZbEOqSnOiRCh+taM5
 n7KWgmLg93V8QQ3zHtg1SqBmUSmihqc2z2n/ucI0GdLW++tQtLrwt4rDwxdUzlUQWdcEIxxR2IM
 9Kg+R7k97BTMdGOHORTFPvDVQOd7MFWoBI/E9awLDdPzVwARD9TX54LA6IacA+Kxzi2gZt6FJjs
 cVncxDMqWzDwJFoQucq8fQdqg2ACj/WrQ1m6Xb9eOAbuTHwhhg+3F3e53GA+E79IzY/6awgXIFS
 6W1ATIvyAF42C1mKQHeMIHBqUeNnmL6lgEg4ULg0BOghVGoP79QFqMXmE9Pbb8aXSzOWbNAxhae
 vILqLGanHgpNSv2SpbnHkNC1llxrADaOFmsOnt5i36GhWCfegXSsmUCB3MBN/1TICkkB2g1uucW
 ff3no2VxCkfVCBdqhcA==
X-Proofpoint-GUID: pvOVCACy9nSbQfAQ-49beYDIDkk02f2a
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a282dca cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=ASywmo1ADVsXjDI2RVyDAw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1k1Y3PzgwnwA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090145
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

On 9/6/26 16:34, Marc-AndrÃ© Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/input/virtio-input-hid.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

