Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D561CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 04:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCVEW-0002fZ-4j; Fri, 02 Oct 2026 00:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCVET-0002fO-Kq
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 00:50:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCVEK-0004kI-1W
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 00:50:46 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6923xQxj1324581
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 04:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XA91vJjceZ/84GwM2ygNkb9YNETfGF7tBnnntXdg6Qk=; b=igGWz4lTI55GXHlh
 cJd6+JyNdNlfwbKAXAQnLlsjNYNkOFW1H8XffFfMh+ENCeSr70g/y2GamkZRwfXb
 yGyuUzvEC8TPJCGXcRp5fX4Ql+Ga2YVQx9f27eIBIyanJiHvKGSGxShOfDxcP1nW
 xkZZyPqwB5PGt4CCbWh4l9Xw4dOsYnOoz+WnUVKOZHDJ4u4+m8GIVZXvgyp++rwQ
 295u87yFbqS0bvW/UNoI5vCXt3EL4cRDu3LZh+deH31kACJvqmjedyrSqIeWgXXU
 WaTKqnlYv/O4qxwmnHXYQolaNSx5A5sk/8i1IuDNffsZEQk5AnpjyIhdjH9SLphi
 qVCd+A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256mr422-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 04:50:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ce7a85f04so82521585a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 21:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790916640; x=1791521440; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XA91vJjceZ/84GwM2ygNkb9YNETfGF7tBnnntXdg6Qk=;
 b=XWyylG2GzyC+NvkgvBYHPVHSNDg+ZvdbJipYlMV3MhaINJUbegLg6C0XFj99078oDR
 uVEmuSvTxV67ZCPH8YG1ot/eMK9vmZ4FQuTL+lWi2oKFgC0eulcFnPtlpqLAslT+cL0l
 EltIYMalbDorq0nuBhKpYjJ1JD6VBQBS5a/j1vXFkHZJj70UhZkVfSor/etyQEVikppA
 r/fxN4kKL9UBGj0Ck4Y8gZ5WWxcN9KmVmZFdJ8046WZOW7IQQoazN9zmV6Bcnr8YmRFh
 M4qG9PxypfhbKI1uCZ0xtVU2szdiQiyt3T+kQHpHyqO2TA6r9pZFLZ/lWjc0PIJKqjhA
 Qkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790916640; x=1791521440;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XA91vJjceZ/84GwM2ygNkb9YNETfGF7tBnnntXdg6Qk=;
 b=u1dqgLm1Q35U2GVPPq7U6w5JoqIDKLzL/olBvUcclupPDvmacsSn8VcW4ZWukmkjKL
 oXqREq2uxPE4UHGOfYted9NLzDvWIDARs0pw/2zbHNmXPI/WjGjjxklMubeLvEBIBtHv
 L1/Ia/YfIbq3iRwcsibW1mwhhP0tIyhaK3GOkxmIYhrMKtyh5KGfcVsSJi9jGlnV8/TV
 ZXCBYNscezwDdqbNvy2gbSpQbuPBewFZOIXYeWFYkEpfWCS3XPfv4jpkMN85HGQ19jvZ
 sFh07508DrPuaT6/IrmVDOSQllgODyj8q9+dImbN5dw567GpOOpIS3ftVZq7motMkM4O
 unhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJystORSyVKXE/t5NH3IweqqmWCmEF74HHmN0ygeC5T6IWNlDk8B5P3VumyhnaktHMnqf4tjShnKVl@nongnu.org
X-Gm-Message-State: AFuF++mQJjnzVWggACB344P6OvdA7LnHDXSPOeJc8+V0IsR3n5LYTa7h
 sN4yMpWxCj5gqyX4GrOfxNo1AJ7B9z1ZTxvGaiqUb0ZnPMGdYOZtyvQ894SYSWtZrEIxhQXGdEd
 mqWaa+ZsmpoPmD1D5AxaanqFCmkotgP3WnQI8+k/MeoPKxWX3jhrTuGbHyg==
X-Gm-Gg: AYBFou0eavoAHHYZdSBnixNOrW5xvfB517jGCbIMYk1iRbmYFIKd83bvYjj1z6WMe+M
 TCfv+6RC1RF1+T6/jJRy+7+Z2O6huod23kVxEWrxzdShp67FyeRpTboKEJHCmtgpZnyqHNc0ydr
 0KKVa2dr029e8g5Dd7Ij3zljdHp798966Of7/VCZs4nLBkxmLWlSSKjEwJAbbEjjXH0J87SEnaa
 BMKQVjjkuKDh+YDPNn3c8d3Gy+XylUHtywIz/W+BG1ymWCcM0gh1LaUvHSkSY8Xz12ZFnfcpmkp
 Ya+TOmOJocY+ONj1GzpYGdePQ3RwXyUzDYk1QuPp+vUDITKAnmay6ws5OLwzVrh78MMZqKo7FQv
 HR7OB45Slh0AukzD2Fgh+Etm9NPIB4nG9rQ==
X-Received: by 2002:a05:620a:84ca:b0:93b:d7a0:d9de with SMTP id
 af79cd13be357-93cf18b0df3mr279932185a.56.1790916640287; 
 Thu, 01 Oct 2026 21:50:40 -0700 (PDT)
X-Received: by 2002:a05:620a:84ca:b0:93b:d7a0:d9de with SMTP id
 af79cd13be357-93cf18b0df3mr279930085a.56.1790916639656; 
 Thu, 01 Oct 2026 21:50:39 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02783af28sm45594925e9.15.2026.10.01.21.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 21:50:38 -0700 (PDT)
Message-ID: <003b6c73-91cf-4ef3-8943-6b8068cb2a64@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 06:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/virtio-sound: Report bytes written in used length
Content-Language: en-US
To: Anatol Belski <anbelski@linux.microsoft.com>, qemu-devel@nongnu.org
References: <20261001224501.1952113-1-anbelski@linux.microsoft.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
In-Reply-To: <20261001224501.1952113-1-anbelski@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAxOSBTYWx0ZWRfX3T+CwRSPVZor
 5f0Rm2gGkVVTW8kLdiSeiZbXaV7SLcAi+/kyHGBYs8YgHW8KwQRea5E99ioOSd+4MDfvt3IMQfO
 2jEVbTeCD4nWfEqn48IJpMXeiflXDtc=
X-Proofpoint-ORIG-GUID: Er-JRufr2o9e4FDrjyWRFw1q7EWqmBfG
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abf3821 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=zUlDYHpKAAAA:20 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8
 a=yMhMjlubAAAA:8 a=r4Q81FmrULDuP0b7pxEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: Er-JRufr2o9e4FDrjyWRFw1q7EWqmBfG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAxOSBTYWx0ZWRfX/UPm8qhr3rJ9
 fBCks5jB7VlF4l4seITVAtpgyLJpKaWaIBaeWUjidcTRgzGkvddVVhvt9fkr7U7bgTGWbn8aq2U
 qcTBhOz+iFAEpOxuauMUsD59H74VpygpwM96zyWVwpuoPg9RyTyj8UzqMc9BDAI87kh2oeky3Tv
 DB2GVbONC9HtslXnpG8VmSQ8CtXFV4gFOq3/EdM6VPDQwlZmNbV1BHu3ai7Ex4ltPrHt98Jlx/L
 NsA15iKviVnWBwyN71ISgjrX/bSX4NiWQ+oFoKqjhLJObTNBiqdMcYwfPIigZ9VJqFYS+lBcZMn
 CTEVbyO/rmTOUP8sKoS8UDXBh4hfDiIxqsqNDY9+yaRTUzDv0Dp/zq4Tyv71gEWIuOReD8t5kKM
 cePnLYr3ZCQ6geItyBR+5DLQyZEf15+NLCCPWQNzUEyqeG8vwuehk95MfjlsezQn2e4N8cPSvLK
 rMMHNlimYE5y3L3/WtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_01,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020019
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cc'ing maintainers otherwise your patch won't be reviewed:

$ ./scripts/get_maintainer.pl -f hw/audio/virtio-snd.c
"Michael S. Tsirkin" <mst@redhat.com> (supporter:virtio, gitlab:@mstredhat)
Gerd Hoffmann <kraxel@redhat.com> (supporter:virtio-snd, gitlab:@kraxel)
Manos Pitsidianakis <manos.pitsidianakis@linaro.org> 
(supporter:virtio-snd, gitlab:@epilys)
qemu-devel@nongnu.org (open list:All patches CC here)

On 2/10/26 00:30, Anatol Belski wrote:
> The control, invalid PCM, TX and RX completion paths pass fixed response
> sizes to virtqueue_push() after copying into the guest's writable iovecs.
> iov_from_buf() truncates the copy when those iovecs are undersized, so
> the used length can exceed the writable descriptor capacity.
> 
> Use the byte count returned by iov_from_buf() for every completion.  For
> PCM_INFO, retain the actual payload byte count so the control completion
> also remains bounded when the requested element size is smaller than the
> native structure.
> 
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> ---
> Tested with the following virtio-villain reproducers:
> 
> SND0005:
> https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0005_info_size_short.c
> 
> SND0012:
> https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0012_pcm_info_size_zero.c
> 
> SND0015:
> https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0015_pcm_info_status_short.c
> 
> SND0065:
> https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0065_tx_missing_status.c
> 
> SND0066:
> https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0066_tx_status_short.c
> 
> Before this change all five tests fail because the used length exceeds
> the writable descriptor capacity. With this change all five pass.
> 
>   hw/audio/virtio-snd.c | 82 +++++++++++++++++++++----------------------
>   1 file changed, 40 insertions(+), 42 deletions(-)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 6df7ea0eb0..52e12603dd 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -271,13 +271,12 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
>           memset(&pcm_info[i].padding, 0, 5);
>       }
>   
> -    cmd->payload_size = sizeof(virtio_snd_pcm_info) * count;
>       cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
> -    iov_from_buf(cmd->elem->in_sg,
> -                 cmd->elem->in_num,
> -                 sizeof(virtio_snd_hdr),
> -                 pcm_info,
> -                 cmd->payload_size);
> +    cmd->payload_size = iov_from_buf(cmd->elem->in_sg,
> +                                     cmd->elem->in_num,
> +                                     sizeof(virtio_snd_hdr),
> +                                     pcm_info,
> +                                     sizeof(virtio_snd_pcm_info) * count);
>   }
>   
>   /*
> @@ -774,6 +773,7 @@ static inline void
>   process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
>   {
>       uint32_t code;
> +    size_t written;
>       size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
>                                  cmd->elem->out_num,
>                                  0,
> @@ -828,13 +828,12 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
>           cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>       }
>   
> -    iov_from_buf(cmd->elem->in_sg,
> -                 cmd->elem->in_num,
> -                 0,
> -                 &cmd->resp,
> -                 sizeof(virtio_snd_hdr));
> -    virtqueue_push(cmd->vq, cmd->elem,
> -                   sizeof(virtio_snd_hdr) + cmd->payload_size);
> +    written = iov_from_buf(cmd->elem->in_sg,
> +                           cmd->elem->in_num,
> +                           0,
> +                           &cmd->resp,
> +                           sizeof(virtio_snd_hdr));
> +    virtqueue_push(cmd->vq, cmd->elem, written + cmd->payload_size);
>       g_assert(s->queue_inuse[VIRTIO_SND_VQ_CONTROL] > 0);
>       s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -= 1;
>       virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> @@ -917,6 +916,7 @@ static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
>       VirtIOSoundPCMBuffer *buffer = NULL;
>       virtio_snd_pcm_status resp = { 0 };
>       VirtIOSound *vsnd = VIRTIO_SND(vdev);
> +    size_t written;
>   
>       g_assert(!QSIMPLEQ_EMPTY(&vsnd->invalid));
>   
> @@ -926,14 +926,12 @@ static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
>           g_assert(buffer->vq == vq);
>   
>           resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> -        iov_from_buf(buffer->elem->in_sg,
> -                     buffer->elem->in_num,
> -                     0,
> -                     &resp,
> -                     sizeof(virtio_snd_pcm_status));
> -        virtqueue_push(vq,
> -                       buffer->elem,
> -                       sizeof(virtio_snd_pcm_status));
> +        written = iov_from_buf(buffer->elem->in_sg,
> +                               buffer->elem->in_num,
> +                               0,
> +                               &resp,
> +                               sizeof(virtio_snd_pcm_status));
> +        virtqueue_push(vq, buffer->elem, written);
>           QSIMPLEQ_REMOVE_HEAD(&vsnd->invalid, entry);
>           virtio_snd_pcm_buffer_free(buffer);
>       }
> @@ -1216,17 +1214,17 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
>                                       VirtIOSoundPCMBuffer *buffer)
>   {
>       virtio_snd_pcm_status resp = { 0 };
> +    size_t written;
> +
>       resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
>       update_latency(stream, buffer->size);
>       resp.latency_bytes = cpu_to_le32(stream->latency_bytes);
> -    iov_from_buf(buffer->elem->in_sg,
> -                 buffer->elem->in_num,
> -                 0,
> -                 &resp,
> -                 sizeof(virtio_snd_pcm_status));
> -    virtqueue_push(buffer->vq,
> -                   buffer->elem,
> -                   sizeof(virtio_snd_pcm_status));
> +    written = iov_from_buf(buffer->elem->in_sg,
> +                           buffer->elem->in_num,
> +                           0,
> +                           &resp,
> +                           sizeof(virtio_snd_pcm_status));
> +    virtqueue_push(buffer->vq, buffer->elem, written);
>       g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_TX] > 0);
>       stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -= 1;
>       virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> @@ -1306,22 +1304,22 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
>                                       VirtIOSoundPCMBuffer *buffer)
>   {
>       virtio_snd_pcm_status resp = { 0 };
> +    size_t written;
> +
>       resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
>       resp.latency_bytes = 0;
>       /* Copy data -if any- to guest */
> -    iov_from_buf(buffer->elem->in_sg,
> -                 buffer->elem->in_num,
> -                 0,
> -                 buffer->data,
> -                 buffer->size);
> -    iov_from_buf(buffer->elem->in_sg,
> -                 buffer->elem->in_num,
> -                 buffer->size,
> -                 &resp,
> -                 sizeof(virtio_snd_pcm_status));
> -    virtqueue_push(buffer->vq,
> -                   buffer->elem,
> -                   sizeof(virtio_snd_pcm_status) + buffer->size);
> +    written = iov_from_buf(buffer->elem->in_sg,
> +                           buffer->elem->in_num,
> +                           0,
> +                           buffer->data,
> +                           buffer->size);
> +    written += iov_from_buf(buffer->elem->in_sg,
> +                            buffer->elem->in_num,
> +                            buffer->size,
> +                            &resp,
> +                            sizeof(virtio_snd_pcm_status));
> +    virtqueue_push(buffer->vq, buffer->elem, written);
>       g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_RX] > 0);
>       stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -= 1;
>       virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);


