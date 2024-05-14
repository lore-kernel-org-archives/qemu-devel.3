Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E48C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 04:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6jtA-0006Ty-W9; Tue, 14 May 2024 00:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s6jt4-0006TY-2L
 for qemu-devel@nongnu.org; Tue, 14 May 2024 00:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s6jt2-0008QV-M3
 for qemu-devel@nongnu.org; Tue, 14 May 2024 00:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715661334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZKp/TlBuKf93gMT7YdCM0l1XqRudfzSO74FbUjgYuM=;
 b=BhEdzzFzQ5ZPtG07MabuCee/2bDUgs/ih2BEWg+DDX0LY5FX14HhRDu4+z6a+4iHT2qNrg
 X4uFb8wN/K3TmF2irQuXZ9GcDHJHbDvTQVQR3JnPeULPIOU/Pu1uhwtrJ/XYxD6bNWe4As
 QS8vT2LXN6VeDQPq9VaUL6FCbz9R0yo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-r4BsxH2HPk-d2pvzHtQLpA-1; Tue, 14 May 2024 00:29:31 -0400
X-MC-Unique: r4BsxH2HPk-d2pvzHtQLpA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1ec5ea746easo15612805ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 21:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715660971; x=1716265771;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wZKp/TlBuKf93gMT7YdCM0l1XqRudfzSO74FbUjgYuM=;
 b=ullmJXg26Vyahvk6Mesgp8w9MeDfnmUFApt1DN32/PrHA47KbFbWPb8C1YZKpUarGj
 1UYtiKyL/MZpduTxfjppqf27j/D6fTi+JfbGK57oRju2sV+AK93M/nk/5XuNA+FvekY+
 SGvpMGgwt++CNXAE02yjOTT0xw4QkSA0MrpmcwybkDV8go2SKS5TDoWQ1rIkD4XS/Eh9
 U69jV01PZVjBcaxtzFfEyTyU1FLPbBtLrhD7KWweSfVgsZrFXMCGqtj+W0OACzb6MMRv
 bCq+VLnOK6LL5cUug18M8bgNYLq1qqC7v9eCgpe6wNk9G/69jmKEuNqp9lE+y9up93QX
 oERQ==
X-Gm-Message-State: AOJu0YyGq8j5L7e8ZbL6VHYc6pNYIaCbOcURG8SMjzrpesnM76zp4uBd
 dS7WnVdcr6gZ5ojDBR/OS3/iaMOr0G7K5zS5BvHjoPWRYMFQ+Q7QyJlmHmSE1bY5UaKR4nD3Za0
 uyf51yvtUq+i/YW6FAdbAHr1wzIvatQflgngmKLhIDdHcuy+aDHqD
X-Received: by 2002:a17:902:d2cd:b0:1e8:4063:6ded with SMTP id
 d9443c01a7336-1ef43c0c80cmr141271295ad.1.1715660970676; 
 Mon, 13 May 2024 21:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLQt2E10xr1OStCVUqwXCm8P/nq61Ahzh49rd1SMpAhTTJQZPyBSHKox5GtQUFmBgka1FOMg==
X-Received: by 2002:a17:902:d2cd:b0:1e8:4063:6ded with SMTP id
 d9443c01a7336-1ef43c0c80cmr141271135ad.1.1715660970110; 
 Mon, 13 May 2024 21:29:30 -0700 (PDT)
Received: from x1n ([67.214.252.166]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c134ce8sm87607195ad.243.2024.05.13.21.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 21:29:29 -0700 (PDT)
Date: Mon, 13 May 2024 22:29:27 -0600
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 2/4] migration: fix a typo
Message-ID: <ZkLop5NJX5Jk04ql@x1n>
References: <20240513071905.499143-1-marcandre.lureau@redhat.com>
 <20240513071905.499143-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513071905.499143-3-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, May 13, 2024 at 11:19:03AM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


