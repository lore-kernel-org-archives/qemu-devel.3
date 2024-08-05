Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7928DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawYr-0007DF-9F; Mon, 05 Aug 2024 08:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sawYp-0007Bz-8y
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sawYm-0000IM-LN
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722859889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwsBKIqnOnRR81AIyVezi7gUmRE682vvNnShAZ/4eQ8=;
 b=h4nMLcRdc4WKdR1i3i69/zAYtvmP6ZlY6EDWzRr2AlCv3OTIH7TA5k9oZNFjm2pZWrj0+q
 VDmlEu/UwVl2mwbMbnumcbvzfouGs3HDAglfuUL0shonXdMinrWOGACx3AArbmtdR0iAiC
 JjQWWQCrEcgiBwz/cJKZmb2iqhillVg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-S9d_DzlvNcC4c5j-Q1AeIA-1; Mon, 05 Aug 2024 08:11:27 -0400
X-MC-Unique: S9d_DzlvNcC4c5j-Q1AeIA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ef17c96309so112180181fa.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 05:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722859886; x=1723464686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwsBKIqnOnRR81AIyVezi7gUmRE682vvNnShAZ/4eQ8=;
 b=Vned+p0k1yDVajLWu/L7m/pqFzsvX0vIbZ5jcH0bZCXP5ICqA9HZurv1JRDd57TDQh
 CPiTIKE0QrzhehXlvEBa41fCKJXXk9T36h4bfeRtB3/k3MhsSXLuU09wKp2l5b73GNlG
 yQKI3bFjlWzuPqZeAvnQ6QPjpPvrLR3mcBseLY9u0sNDyW2WJTJxZ9Ea1pqrsq1WP9U/
 HG+GGsFoGfjzYSj+1WRzKcQHohiPknyzmYeA31Qo9Idk9qtV+6UR+7se4xiyuBobIuTm
 /n6HgxEhbZDlh6GgWmiEHT7dAwML7+kELEKh7veX1e/zKE6d7sfhBcwnmQGEzNsD02zi
 9saA==
X-Gm-Message-State: AOJu0Yyf/5XTdKJfxxOzNo4kU+OObm0QbSAVcPoIXPNDgdem8TrV0t9l
 Wi+xXTX/629oJ+2Xod9fzDxHUcUYQmNsa7N1Y0ywSXr0Of+kxGeNiC4LbfoFlq/u/KcuQ7QOg/s
 d/8ZuDhGiu73dkG8MvFnqmI8wBen3OwTq9uGwp6qyGrxtjUjWGlRX
X-Received: by 2002:a05:6512:b1f:b0:52e:9d6c:4462 with SMTP id
 2adb3069b0e04-530bb3797d6mr7882019e87.23.1722859885839; 
 Mon, 05 Aug 2024 05:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg9ZyYxBFFoGBgSNOmc7UHnHu6XLhb82mj0isJ9nKDJzcVC9SND3OWmWtU16mAgetUpH6+EQ==
X-Received: by 2002:a05:6512:b1f:b0:52e:9d6c:4462 with SMTP id
 2adb3069b0e04-530bb3797d6mr7881993e87.23.1722859885278; 
 Mon, 05 Aug 2024 05:11:25 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bcad43sm453460466b.19.2024.08.05.05.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:11:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH for-9.1] target/i386: Fix VSIB decode
Date: Mon,  5 Aug 2024 14:10:55 +0200
Message-ID: <20240805121054.481294-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805003130.1421051-3-richard.henderson@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> With normal SIB, index == 4 indicates no index.
> With VSIB, there is no exception for VR4/VR12.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2474
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Thanks very much, patch queued.

Paolo


