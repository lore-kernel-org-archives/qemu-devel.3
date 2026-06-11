Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F87CCD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdUq-0001C2-NE; Thu, 11 Jun 2026 07:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdUn-0001Ah-BH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdUl-0000xn-Gm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:49 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA1pTa271455
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lh5iVNW5xZX0JSuGHJRy/a1sQvVC9uMeOchPTt1b//Y=; b=TlN/AOD1Q3J2rIjc
 hbuDPFkTgaKKx0eIWpdu594CYpFef0i5wzYwz9XYqhh7QooawexTDuxSa/wJyKhI
 J3PPf49FrYT5DO9ZdvhN2+NZLV6cWVjI29AYHk9sAcetUV57YX6PyJPuTv5BvLlt
 BFvoCzyJrbXLzkSNi0FwOz3+TftikU827rn9YikcWu8kMeUMk6YEJwBEKtO6Ocma
 9LyTqjbuDMFZI8QOk8YaHYVCBD1lwUNmNz/cSn3gshJ7DR3xGtZwqITR4aIrvLgD
 3d6+ORB1zfOJCxhjqtr1clitFRAIXyoNEXDJh0BRJuNTM7w0MkbOMayW9cIHUnRA
 35TvSw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe71k7ny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:22:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8cced8f230bso169124276d6.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781176966; x=1781781766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lh5iVNW5xZX0JSuGHJRy/a1sQvVC9uMeOchPTt1b//Y=;
 b=QrsGHHdUlvAEeguUiSp6aKCiKhOebPP1Wil7jbRhat5QrKiJwXtW3SUCVI7140DzKs
 TloztGcUZ1ZoEu60+NdKUA108Gk5qpW9rfcF52+95KJJ/lCfpBFBackYLzc+nx6be6VI
 vqYXqUxdXw9EOR9kKXOhP4bsUL9es1xftSpu3smvVV6imLhlidQduH6V5w1yTd2Bn1hd
 i4Y7/XcifLWx1hoEYHoyXB3F8dQtJ6faBDNS6MbgRkmJKdVsGYWTMXJ04sKKCgWlC9eB
 p6l+ZG/OnNwKKeybIjvIfmY9NwlvInZmX85u/QT7PUJ+0T42jfH6ab0CD6lxcjvqExfV
 Ivgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176966; x=1781781766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lh5iVNW5xZX0JSuGHJRy/a1sQvVC9uMeOchPTt1b//Y=;
 b=DnJ+3Dqca9XrjuZNcqICEdFRh12gzaiBntALm2IdloFZ415tEJKB0TjqN+RXJWbRnv
 X2DIIjhIBl1wJHru9pQ2HAqYzcukX2MqbM1jUh00LiKpA4VRRqtqfPAIILInAVWtCI7K
 5vVUCvs1zG5mIxN4wWLLQur0OBe3QboAXJpNqsiJzgpZe/aMNUEj+L9OAPFyBEvAs2PP
 sD/RFkGWFSszr2PRd6ifvGMDEErOoebc+i4C9Vni6/+YotgKXOzcy7C8O9cEMFkRz+VR
 vpHw2hnNtnoXP8PKKofrEQHSnJzRfYkTKdcW95wdqYkAkbKVZh2GF2EZR25INELEDVdF
 3iUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ92v1kz0cBUFDgs4luK2fq105CmzzxmUNrQD/SNroP4n10u0HHuLOJB26Jg+c8I9WObDvFQgSBvCyOh@nongnu.org
X-Gm-Message-State: AOJu0YxQKObtR2sc5ds3nN+Ulm6SZ8z6cqSYvqJ8BKDeMDDCfv1R4A9D
 rab4wRh8YqNCGvG6paN7IXnAK+E4N7u+omFY53/4yYh3JBwRQsSrNcXCjkxnYEkdSDTRHUzK2LM
 OOruXBllUyWkWqxjtsA7GRLVaX6bLLdBfZvyQdFY+wxgASePl9VqrIy3wPQ==
X-Gm-Gg: Acq92OGv6WLjhK0mlKRa/Aq0Hx1ZkVpHdL+N0kb/VwJmFHeWkTPw4GFs6EbY+N9uYLK
 d3d2ZzCpJiyPamNh5+ESbgKftFIpD2l7rraV04NJvNqrvTxkEdB7scGLIzs+hiJChBF4k/6RSwj
 7N9lTQ+piyQR9anXIRiCf8zNg9L8rccJSCotBbxJOL/2ccA5GmuhF7cPX27ixE7xXcV5Ne9tEYY
 6A+rK/SL1YkAgZgLc4EUKUQ6SWrq9axzdkQmjq54WO7qYIv1p63FSVfF1rXwJrRRXd9ofbTQaIh
 ay5N3lShfXYelpUKzrICcX10xmjynP8Sctgjq9v6f4qXwEHqPmYyHGIjDg3pBTea2QN93A2Kden
 MXmKmNP2h7LEZbLWwBywf2f0APPJx46/7tSGz4MQx6FFAZ1tWoudYZ0eHbhFY+9zSiqRVZ1+6e9
 FxdmsgZyKfjFfO
X-Received: by 2002:a05:622a:4807:b0:516:d83c:edb6 with SMTP id
 d75a77b69052e-517edd1b350mr39495651cf.12.1781176966017; 
 Thu, 11 Jun 2026 04:22:46 -0700 (PDT)
X-Received: by 2002:a05:622a:4807:b0:516:d83c:edb6 with SMTP id
 d75a77b69052e-517edd1b350mr39495211cf.12.1781176965661; 
 Thu, 11 Jun 2026 04:22:45 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f360bd6sm87145359f8f.36.2026.06.11.04.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 04:22:44 -0700 (PDT)
Message-ID: <e9b8218b-39e3-4ab3-a2f7-3cb52c812582@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 13:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/22] hw/input/hid: use qemu_input_handler_set_led()
 for LED state
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
 <20260610-ui-input-v2-17-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-17-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hlUP7H9q0w9NxVhnfkvtoeaBxGolj3G1
X-Proofpoint-GUID: hlUP7H9q0w9NxVhnfkvtoeaBxGolj3G1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfX1OdVawIV5Y3/
 U3n67MucKqz13aL0cmO5fIaAKIEFoelKE3W+tDuNztbj8kbPmsQw4430H44Po8OoU+k3i+1D8ct
 okMege5R84PmUkNS5PJ+lpHanHLXRdvwu9baashqGfxkfVNusNzl77eiJeQ6dI2rYqFJKJeioOo
 BBrOFxkEPU+o3r6dm+8z25vUhonvmTN5GfWGnO/9XgzZeFbHgUUVGSlG7T2RylMUou1Qn3KDsIb
 wO1fbMpTPdCDHp2KYniMkfymOx+d3hCHDr51U5ysBqvAfLj0l5tBt6YBXFb0x12Jqt+VodfXWa5
 b271HaRGjPLJlkb80+PuPj7HHriV5p+cGrLaMFOwiwTelM8r8PBED8mIIDGj3cngE1pn1Lfrggg
 JivuPnJNL6ymQypIkruTI5gQ3Xz3nIl6RyYBPtHxs9OsrdeNelm/cEZRPJZTqS2EJF7urKo7cuX
 afs793KUiDk8sAwU0QQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfX2IXMk+SXgJop
 m4T/MAHxfIG2COtUH4DFGJHoEbzGTIwoomixnJnCe2jhZT+S5Cy0iI1dw1jJTscOxuXLC33qj64
 OtMj4h0awJ7MXgFpwWy7X+iaicJ411o=
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a2a9a86 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1k1Y3PzgwnwA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110113
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

On 10/6/26 12:56, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/input/hid.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

