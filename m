Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE0606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b7W/UXmX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JyudE81W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWyY2-00088O-Na; Fri, 27 Nov 2026 11:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWyXx-00086B-Gv
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:11:37 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWyXv-0005A0-S7
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:11:37 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFowMq1703833
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 16:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HegrYo0ivagOh3jfbiEMHTQk2sQOHcQMocFWyVg5reo=; b=b7W/UXmXaIfDK+x/
 EeHlZp1s0bPH98dLV7FZ2yyGQ7EUquSQLpZg5FSA3vewJu9LAPQK1FnRjY6WhTBo
 qU/KVIMH6QWMtJKzbYrZgvsiQSiIa49G6EYEbiw0cxYlM/05CSSlshSD6Vf8ypRB
 SRtr1lqGEaZ4PoVh4jDyQNoXEc1n3zKdt1rRNCIohZvfZhCqwwy4uEpVG3qltxz8
 EIgzbEIm08nZ5Z9BxreeWy3frpXxBSEmJZYaFwfBLXlsZa5Xh8tECSq789Ewa0Rm
 l6iXkyuTuqeSYiON4UcOY0A5uoIl841vg2ALtUVYbEUWkFUoVoIBUTBFFXMkvlmi
 aCqOtA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqmr2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 16:11:32 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7d32175c486so1173881137.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 08:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795795892; x=1796400692; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HegrYo0ivagOh3jfbiEMHTQk2sQOHcQMocFWyVg5reo=;
 b=JyudE81WdF+GDmYaKZqkAGJ5JtjVBQjOI0a0qxoCW9hiZsvuwPAAuqN2WG0apTQKBf
 sBx9szJBzvurefoo3Q5zCnu4C3lU78VF6ZyWsrTsvH7mbIzHSH2SJ2GjpMS5nEIn014A
 6bQvzuejV28gepuqK44NZ/YJTTiWeU8EPgKhgW7m9bY2/zCRCW+t4iHqLDbJ2BmqLZCI
 3NxWRLq7Kuqow8yLH0XdjajZLne8gxLo1PitLWPmMvec8Q1EWWYL6CjmknUlq3VR9sIJ
 xUfVyExcqk+HIuMWtq15ttvP71FJ6kbUoW2VXAg5a0XNFo/NbC1A6pUrTOEr6kcTtxNQ
 FeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795795892; x=1796400692;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HegrYo0ivagOh3jfbiEMHTQk2sQOHcQMocFWyVg5reo=;
 b=2p97oiXI+2xzo5SX0Wys4aF/5CXUfT/Ndoxkj6K15gwieU7LerbGn9D+/RuIvFYk92
 PEviYKA+6iLkZwiJVlOPM5vLq5BHcUZe5k2htY2MZMZEPJDOtQIeVBPS7AmZ/7CodBhi
 k2tFmxqBi/SE8s9peF98InQBL1neZZxcpybwGGx40yMzBK4SLtHdlfGyc7jlSOJPGvhU
 USgUs81yqpu20Ty2r0Lf7grzVeapseVcFtCkmQlz+OwT7yhfFypu36aTu2ttiebRHoGh
 a4aFNlBo3uQJm6ngssTrXO6xyiH+HTEWCvKPr1SyI7CwkOYOEB4fo1LIY99G2SZQaSkS
 /E7w==
X-Forwarded-Encrypted: i=1;
 AL+hErGwJ0FFfZJ9UuWbSLUjX+e3h+GmMszf0csvmbGYYaglQnhoxLoTEXXbg8DlORobP2BmBkZA4kKAAbXe@nongnu.org
X-Gm-Message-State: APuU4Z+xQsDXci82QtXRCv49rmj02WorCr5iRnw4LTkxuBt4LpyH8dWx
 f8kMflsQAyuU0l9DbA/iN8cqA3x++UX9BxhxJ3VZA8i1QU+PM1u0L3gNQpbWfR1vWa+Rr3N+1qi
 euEkbJbzvjSoGnFsQaZvKCTXIylRLGiYyHIjCkIlMXSJRViRTV7o949ZQHg==
X-Gm-Gg: AZFdTZf24SOn2i5EpZhcrpMTkQKnowiAisplVmYpnCWQAv5ViGPldzLIIBAyqvQr7X4
 Y8sKQk7Jt7q++RwftVGPZhphQsLbJOfs7nZiZaivQaPl19fS/mTnRI9DtowuejUrffJ1WpTgliE
 toncrQ8vdL7wMR5HEQnjXTAj8Y126VWe85R49MgVTkNG/IOb9Cw5WqqboVXRJzP/C2ncMAeXdSU
 Wn/38Sm7zXuf2Ha5XWxnyt4edrvv7OIyoYVDi0Pfd6G5EfyOTtfOrwX28u5HP54VGH/L+w/h/9a
 R80ujUfGRegrxE6HIyXHQkoD3ZXdHTwy4WP1GFJmT0tvDFhfls5pgZqdtEIkIsqRWfm7icUOtW5
 O7mfQupif/fcHelxryaHA1qUiPOwg4Jsi32Vxy3d0jgyH1a7ZIP4mupYe360oq5396Uw8VsQQbw
 ZLYFzjHiIGAynMtg==
X-Received: by 2002:a05:6102:5811:b0:7d2:76af:fcce with SMTP id
 ada2fe7eead31-7d7393c88e2mr14054987137.9.1795795891825; 
 Fri, 27 Nov 2026 08:11:31 -0800 (PST)
X-Received: by 2002:a05:6102:5811:b0:7d2:76af:fcce with SMTP id
 ada2fe7eead31-7d7393c88e2mr14054943137.9.1795795891328; 
 Fri, 27 Nov 2026 08:11:31 -0800 (PST)
Received: from [10.60.206.224] (192.89.66.37.rev.sfr.net. [37.66.89.192])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae9dc7asm890969966b.41.2026.11.27.08.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 08:11:30 -0800 (PST)
Message-ID: <8a0fb57b-3d87-4fff-a30a-b3c50eb0bae2@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 17:11:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio-net: Fix crash in reporting of
 virtio_net_get_vhost() failure
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jasowangio@gmail.com, mst@redhat.com, Nikolay N Zorin <zorin@swemel.ru>
References: <20261127152354.626137-1-armbru@redhat.com>
 <20261127152354.626137-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261127152354.626137-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GYixgzUKeJDYYwrx4H6tyLhCXL6F_imp
X-Proofpoint-ORIG-GUID: GYixgzUKeJDYYwrx4H6tyLhCXL6F_imp
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b09abb4 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=2npb9OLYoFXsh95gv5+vWw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EWWzKEDAAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=GfoAO_V9h0AnWOYRO9AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=8ZwbcxVZO41N_bDMix7v:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2NCBTYWx0ZWRfX+C+DKBkB6ZPh
 gHPDdFpuhWSVijUMS/mF38WuJ5/6CLSSoOZUDlwnRTvZ1VNNiI25ZV8F39KfDdHwdweERjECv8r
 2cI77lWiPv+Q7bPifEOmQ8/AtwDuaaQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2NCBTYWx0ZWRfXzRLdPa7bB0up
 hwa2jrXGZmG9xYRcwkVY8hxOd7BxMTO4SFaj2lQg5gh9FQs1TnPo8CK7bawSPK+5MU85hG3GCui
 7aGQ5J2ASCjIHCGURwu0k4lY0Oes5d/nULSgFJXE7Ja+TpDRd8rVfFgWesXI4/gYiMbsg/tfwQs
 d0Z9Mvy5oPCd32a30GEOVGs3phMAXCUlY5JDb9k6yXhRaUCLvA57FvKLg720vyU0jsK7+33uvAc
 4ibQmODvp9MpDG6iPEVragKjoADCpBoIFEauCMcD1o+RF8+miDVuLcXVr9xpqbwUBR48nXHns5K
 NjxiKoBgskdiW8XUTPEiqT0oGcJ7oCZh55w2Pz0dp304dZw9fb3uAMEHs+uWsIingFm70euMrtn
 15wARhK27ks+NBGY901EgrKNarySgqk1RhIHSAybPMp+QR5HKhfELbDEeLnl7vDNNZC0M5OabOn
 9jB7guM3IgP4moGlh9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/11/26 16:23, Markus Armbruster wrote:
> vhost_user_net_save_state() and vhost_user_net_load_state() pass
> @local_error to error_reportf_err() when virtio_net_get_vhost()
> failed.  @local_error is null then.  Use error_report() instead.
> 
> While there, tidy up extra space in a nearby error message.
> 
> Fixes: 60f543ad917f ("virtio-net: vhost-user: Implement internal migration")
> Reported-by: Nikolay N Zorin <zorin@swemel.ru>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/net/virtio-net.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 36edb768b17..6ebc5b1d2fc 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3587,9 +3587,8 @@ static int vhost_user_net_save_state(QEMUFile *f, void *pv, size_t size,
>   
>       vhdev = virtio_net_get_vhost(vdev);
>       if (vhdev == NULL) {
> -        error_reportf_err(local_error,
> -                          "Error getting vhost back-end of %s device %s: ",
> -                          vdev->name, vdev->parent_obj.canonical_path);
> +        error_report("Error getting vhost back-end of %s device %s",
> +                     vdev->name, vdev->parent_obj.canonical_path);

Pre-existing, @parent_obj is internal field, we should access
it as DEVICE(vdev)->canonical_path (this is error report, not
fast path, no excuse).

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


