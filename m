Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297D6CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblXM-0002Y8-P6; Mon, 22 Jun 2026 16:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblXJ-0002Xb-Mr
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:46:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblXH-0005iB-VU
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:46:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZciG178944
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FQSDqfodZxSuovx12aCEkY78NKTosQqgTYYIDNeLDHQ=; b=FGkL9XLTXlUMkEfm
 xc8N0iZ56X6YDcSP7wRMPRs6ZkHklWFrHC2cPJXb5trTR0pORzXK3wspoq9QU2DI
 8hRm5zbvGBTYnXXVAPwrenSrAnAMts+kvWpafT7ABSybuDUWMaunIwc0iMlBr8CD
 GohNqUzPNzI/taM+o5O3ots7nFNqlEApW5e/SIF3tXcXj5/t9RcjbUDq/vSH+uEi
 L+MKatCXCIPZrdOCTe7Qv8kesmOCvJFZHHLZfUi0BReznLW86z1B+MjV1vNuQwfk
 Bfn4PvtVrdhrDtpidjdAusUHspd3H7SoLhU8OmIQr4rFmD0auFJIQ8eHKKN9Qr2i
 hp5haw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yht8vc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:46:25 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9673c274512so111016241.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782161184; x=1782765984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FQSDqfodZxSuovx12aCEkY78NKTosQqgTYYIDNeLDHQ=;
 b=VN+VVoqMl29ou0LJubDtds9yo/hzAylr8O1Wok2fEQm8x1qmzC6T4aK4fdEFrbpSCc
 gsZyWdhZ8qtNON/I0FM3HJflzHOa8ZPYl/2KzR879lzsn1/Ava8tJSxWc6vTJNkCAi5/
 lzYPSpSSUlGFEd2mG8U8XTLsnxdXgGw5WcODOO2ozvyIXxF9PfDII/thF1L4FhjjREie
 enIULgdgoeb85KBF/SlRzeKeH9mMCn34JKb+LOE933hLisWYpEJXK26ddPuHWOE9GTNm
 2DMb5BpR+GJYV8EgjqkAhIi0U+P2kE07EGcMfIdo4J21qfOlA+KELbDAvWqul5WLT1VR
 QLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782161184; x=1782765984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQSDqfodZxSuovx12aCEkY78NKTosQqgTYYIDNeLDHQ=;
 b=tPEX4m7Hvs5DPGnXWVS4bK0txld0r+ZE0s832e7bgnlEUvPHu7a+WchBNeYfsoGiFG
 ocyJA8eF14hNptJML1YCU37KduSugL1d19naDrQQNeoGLXIU15Rl511PMblUsPwHAIic
 iiWL7HM16aezjvGbWhYg1oeoLdPMpOgYU4R9YVXJ/H4D4BreUckX/SQ14sj08M/aDeMx
 mMR87TNl0tXqi2dxXAXKEvB8GGnBXzUpeDTkEVDcTGabyk88Kqn8uigNhWp9MSh2Ilq9
 rVBxHObbF4b8Ego7z8DKCarfxML/02904TWgTdz87gQDwXhbDU1p/u4KUEUOiew4yOvj
 eSEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TmZ72y7SfutkEEVNL3N6m/3taH+HGJbwT7Bip/ONiuczGxBIyuENlZEF6hwDlXkRHr553mCNRE0sy@nongnu.org
X-Gm-Message-State: AOJu0YweXtYxXlPc6tTEXTyyn3dMBRNjpnT4VsASJvD+PUcPg4/EiFHo
 tTV+Ic1L6tITL24bh2mnR5IEhehFQEU2QqpczwOLI/CMN7g9ZgJYEy1nd+8+F6VGxBL/rO2LFh7
 FFXAQ0dplfYl07pmuJ4sqTroEqHRJorjNJY1JERacY6RxJrsPvI+h5vx5Uw==
X-Gm-Gg: AfdE7clQ/h3aXutDWRkkGipfPTXNt4Zsi8ht3doFfTI3TmRi8JzKPXK5YUZwsntM0tW
 Jc0q1dVs5mX0aWut+uTmmiAthPojUcITfIdt/pdmltI4ZDCV+WQozDvg2CZ8aIvEfboPNlUCVeG
 tYeT3YVfWPsQu6WEItk0Miu16QH8VHQ3edVVTe4weJCWfauyMUoTqzz7h8CzEZWScVV6KyoODB2
 z/aj75LraBLsvrzKIOuZ9O3/85+A9NJdqHhkaTHTj5lvyrvta67N/Q0o6a0i/i4oN0wQ0a5HQuP
 bYHrjKIzfZ65xnh0rmN/9OoySa6y846s9pKYH+ppNsaarOEV3NlspxcLqlYa3SIoQU4orhFj9Mf
 lB/D65oDvbndKVZY/JNwHVeJah51AvEzlQjLYmBCHNQjNfM7cGzUGkBrc1MjATg==
X-Received: by 2002:a05:6102:ccb:b0:631:2624:e5e7 with SMTP id
 ada2fe7eead31-72a788642b3mr9932260137.14.1782161184004; 
 Mon, 22 Jun 2026 13:46:24 -0700 (PDT)
X-Received: by 2002:a05:6102:ccb:b0:631:2624:e5e7 with SMTP id
 ada2fe7eead31-72a788642b3mr9932219137.14.1782161183601; 
 Mon, 22 Jun 2026 13:46:23 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466667881bfsm30798261f8f.22.2026.06.22.13.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 13:46:22 -0700 (PDT)
Message-ID: <96ae9ccb-6889-4c21-b6c3-b112b522d5ae@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 22:46:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/pci: Propagate errors in vfio_pci_load_rom()
 using Error API
Content-Language: en-US
To: Mario Casquero <mcasquer@redhat.com>, qemu-devel@nongnu.org
Cc: clg@redhat.com, alex@shazbot.org, philmd@mailo.com
References: <20260622120904.72378-1-mcasquer@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622120904.72378-1-mcasquer@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwMCBTYWx0ZWRfX8dtlu5ITqLEq
 ia+VOcCf3OJv/qsno73Mqluzj9OWCl5M18gULsUZC/s5psouONfI2goTiasY7DwIMiezbWizdDC
 12MZmNjGg29Zg0mu2eaUu3s399lkpS4=
X-Proofpoint-ORIG-GUID: xza0lU2RxQKbLv68-qw8PhcPEXJIz8Wn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwMCBTYWx0ZWRfX8oD15WGf6Ec2
 tc/T3TRxSGcVh4ge/WEW0svSx86nL05X5L5XI8ihlkdL9ihehpG6qYp1Krqk87idFga4y3dJWLQ
 7JHd2/q5sZ51mNxcjKclVI3S7oNMERHezf38JomvgOXH/q1uVHuN4sps4NYj0+N1eo8c9VvwJF9
 WN2Vf8y2wiluRiq05nQhNjfRxVJsYEDk58IziZlaexL0XL5Ti2eSIgu/1ZN01dpIQd8Wi4CqBnr
 ba9npxofmSjtIBlO/Mysdte3R+yPgKxrRFmrvnB7FHVnkJqoyn3qMDBvxp7yywA9PjPJ8pdXyGt
 fZH6bU/sn5esMRnudjG4mw5xoyz7JM96WSMylXnWCyo8dY3ZAIHa+Vv6xGwBGye1rh2r97Q6QCh
 AM0TGjrwsL0/M+TEdlR3fVStgrk+zKTVrHIm0PTIbLjOvQy25X2wKVeyWP/XsB3hZUZruIfajkt
 VLE5r2Q9owXlHTyMaIg==
X-Proofpoint-GUID: xza0lU2RxQKbLv68-qw8PhcPEXJIz8Wn
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a399f21 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=fsJhM2AEymiuGlh_OJwA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220200
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 22/6/26 14:09, Mario Casquero wrote:
> Updates vfio_pci_load_rom() to use Error API for error propagation
> instead of error_report(), improving error handling consistency.
> 
> Signed-off-by: Mario Casquero <mcasquer@redhat.com>
> ---
>   hw/vfio/pci.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9df04fa2d7..e7afcc0a1a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1027,7 +1027,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>       }
>   }
>   
> -static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
> +static bool vfio_pci_load_rom(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info = NULL;
> @@ -1040,7 +1040,7 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>                                         &reg_info);
>   
>       if (ret != 0) {
> -        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
> +        error_setg_errno(errp, -ret, "vfio: Error getting ROM info");
>           return false;
>       }
>   
> @@ -1052,7 +1052,8 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       vdev->rom_offset = reg_info->offset;
>   
>       if (!vdev->rom_size) {
> -        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
> +        error_setg(errp, "vfio-pci: Cannot read device rom at %s",
> +                   vbasedev->name);

Pre-existing but is it possible to get vfio_device_get_region_info()
returning no error but the get_region_info() handler filled
vfio_region_info::size as 0? I'd expect
   1/ "Can not read device" -> -errno
   2/ errno=0 && size=0 -> error msg distinct than "can not read device"

>           error_printf("Device option ROM contents are probably invalid "
>                       "(check dmesg).\nSkip option ROM probe with rombar=0, "
>                       "or load from file with romfile=\n");

While here, let's replace error_printf() by error_append_hint().

> @@ -1076,10 +1077,12 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>               if (bytes == -EINTR || bytes == -EAGAIN) {
>                   continue;
>               }
> -            error_report("vfio: Error reading device ROM: %s",
> -                         strreaderror(bytes));
> -
> -            break;
> +            error_setg_errno(errp, -bytes, "vfio: Error reading device ROM");
> +            g_free(vdev->rom);
> +            vdev->rom = NULL;
> +            vdev->rom_size = 0;
> +            vdev->rom_offset = 0;
> +            return false;
>           }
>       }


