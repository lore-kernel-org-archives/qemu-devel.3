Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED06CE7AFB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smVxD-0003fv-FM; Fri, 06 Sep 2024 06:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smVxB-0003ey-Si
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:12:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smVxA-0001MP-74
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:12:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42bb8cf8a5bso14146025e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725617550; x=1726222350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nJy78F5y1+nupqSnANgfCASttwASox4hh6N29aspzhA=;
 b=mwXr0oJwmPzFQlQsy/lKmz7SS/VpDpk1PZWJ2q3B+/k3F8Ze17jDhjZZ0TMNyTFGZb
 hM762aipbCLGbWunCpXnlrO+lIBL44LPyH4zcZ9SQ7NvMgn0S1szMERSdx8G6mnB99xR
 gfBgkv2mmRAikpkaDiuijuA8YhWf3cOEceyD96TYbGLhmcz3n8ppV/JNVkmBKNwXF6Yi
 SRtngZPVwbKRR1J3QS3NbvQCXSHwDvwxvcutlD6b2wJ0Easr/hahGP+ba4zCRkJ2L2I6
 KI9D50hLdM5UnT6G4NHIhDLC1Z9yIN93XT9N4wEPQKnX1sRCDGua+qSZVfGeIG34TK9q
 fqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725617550; x=1726222350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJy78F5y1+nupqSnANgfCASttwASox4hh6N29aspzhA=;
 b=P0FtgcVk0c7GKjDwBQ8GPZjTQnowUbisy/6DH6ViJNmiKTJDdpcQzkNB4A/duTvGv3
 mFiuwrHOxGS8Rczx79eW9YbFJevvFaU5InsHci0cVBsBfy+EYVm3607pd4UuBmSK6VdM
 uRlA7vZJp3FBGAQ9yF0FMu1CoHfE5lebjhniXld4cBh6ebESiH9+oum0ANWhfS+clOCG
 jYmTAtGU44aZ0cdZ07EzQRkOgMl8GST6MkYuo7AnDJ11n1FuZGraMG8HtDca59NDv4s6
 QTK9O9n3+amq88zJES58RvGqhij3xwgjDpyAgpiDFYQxqQEhCRJB+KNk4KEPc7np5TYB
 QwmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVidJaLppvxLyOxjh+KV5NOedybH5SRmRBwJRei/PeuVTtEiGWj+BARlYwASTf1+OG6WImbtd3n6nLu@nongnu.org
X-Gm-Message-State: AOJu0Yx60WsUmTuYmwlGEzJsR2T5VAUwoM3+sMV4ORiEffuCyjDEx+7P
 IlmDQwLXgPZ00FK3t1juA/587g6PwTxP2Pwy+Qo3/aoVU+KdrkUBLQ64CExIt90=
X-Google-Smtp-Source: AGHT+IEasDf4usPg8m9augxKxP972z+RvuZh5MN9PfdQp4+1pNDn+0eFm7dzQA3S6hlx3VLN6upJaA==
X-Received: by 2002:a05:600c:45d1:b0:426:6220:cb57 with SMTP id
 5b1f17b1804b1-42c9f9d659amr15238565e9.25.1725617550291; 
 Fri, 06 Sep 2024 03:12:30 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374cc75a5fbsm12198685f8f.80.2024.09.06.03.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 03:12:29 -0700 (PDT)
Message-ID: <85e541b7-4207-4345-9719-9f6353ba9232@linaro.org>
Date: Fri, 6 Sep 2024 12:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] hw/net: improve tracing of eBPF RSS setup
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
References: <20240905181330.3657590-1-berrange@redhat.com>
 <20240905181330.3657590-8-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240905181330.3657590-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/9/24 20:13, Daniel P. Berrangé wrote:
> This adds more trace events to key eBPF RSS setup operations, and
> also distinguishes events from multiple NIC instances.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/net/trace-events | 8 +++++---
>   hw/net/virtio-net.c | 9 ++++++---
>   2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 78efa2ec2c..6cad34aba2 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -399,9 +399,11 @@ virtio_net_announce_notify(void) ""
>   virtio_net_announce_timer(int round) "%d"
>   virtio_net_handle_announce(int round) "%d"
>   virtio_net_post_load_device(void)
> -virtio_net_rss_disable(void)
> -virtio_net_rss_error(const char *msg, uint32_t value) "%s, value 0x%08x"
> -virtio_net_rss_enable(uint32_t p1, uint16_t p2, uint8_t p3) "hashes 0x%x, table of %d, key of %d"
> +virtio_net_rss_load(void *nic, size_t nfds, void *fds) "nic=%p nfds=%zu fds=%p"
> +virtio_net_rss_attach_ebpf(void *nic, int prog_fd) "nic=%p prog-fd=%d"
> +virtio_net_rss_disable(void *nic) "nic=%p"
> +virtio_net_rss_error(void *nic, const char *msg, uint32_t value) "nic=%p msg=%s, value 0x%08x"
> +virtio_net_rss_enable(void *nic, uint32_t p1, uint16_t p2, uint8_t p3) "nic=%p hashes 0x%x, table of %d, key of %d"

Nitpicking for pre-existing error, unsigned format is %u ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

