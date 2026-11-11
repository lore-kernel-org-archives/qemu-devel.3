Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF9606A889
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=K0/LCaLE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR8Op-00049D-EA; Wed, 11 Nov 2026 08:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xR8Om-00048H-2Z
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:30:00 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xR8Oi-0000T2-8t
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:29:59 -0500
Received: from [172.19.247.154] (customer.sttlwax1.isp.starlink.com
 [74.244.199.159] (may be forged)) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6ABDTlj1016291
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 11 Nov 2026 22:29:49 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=WuSgZE98Z57loyi+FEEcKEYZ895aHZywkYvf6RKreIM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1794403790; v=1;
 b=K0/LCaLEGXVHKlaTRyJigN8s5vVoSedRU6GfivZOIuYlfu/TTJjDv4/oxq00aWrk
 D9RMY/BUGLn7Y5uEhqoTcEoG2VZIs1wXa4R+bvs3zyhyuU5yEq7UJZNSeHa2VItZ
 GL4n/DPtpfOdE+XZ4aPAwXVMpMqIZBBFKfR+f3n2t5HC9sc7wGDwFU1Za1TPAkz2
 3FG6UfLKHPHUNFKY8iVZQfzPHtBzB9HfdMC9DAY4MQQssvznHtneEeiJS45zDviq
 l8+3xXtkSrpJ1pntWKqlgxRsSUw8fItn6eBcigYK8lgd7OweSUt9sXq0/hTnsWY1
 fmyhXLYeMb/wUSv54OgDow==
Message-ID: <42bebc08-670f-48b2-8b12-63309feb5b8f@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 11 Nov 2026 05:29:46 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] contrib/vhost-user-gpu: reject non-32bpp cursor
 resources
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>
References: <20261110-master-v1-0-7a0505d6c259@redhat.com>
 <20261110-master-v1-4-7a0505d6c259@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261110-master-v1-4-7a0505d6c259@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/10 17:31, Marc-André Lureau wrote:
> Cursor pixel data is copied as 32bpp, but the resource format is never
> checked. virgl_renderer_get_cursor_data() sizes its buffer for the
> resource's own format, while vg_virgl_update_cursor_data() copies
> 64 * 64 * 4 bytes from it: a 64x64 R8_UNORM resource gives a 4096 byte
> buffer, so 12 KiB past its end is read and handed to the display
> backend as cursor pixels.
> 
> Look up the resource format and refuse anything that is not 32bpp,
> matching the virtio-gpu backends.
> 
> While at it, let g_autofree release the buffer: the 64x64 check returned
> before it was freed, letting a guest grow the backend's memory with
> repeated UPDATE_CURSOR.
> 
> Fixes: CVE-2026-122027
> Fixes: d52c454aadcd ("contrib: add vhost-user-gpu")
> Reported-by: Fernando Bortotti <https://gitlab.com/fernando.bortotti>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

