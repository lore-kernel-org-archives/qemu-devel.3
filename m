Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1489EC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 21:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCn2N-0002q2-Ce; Thu, 30 May 2024 17:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCn2M-0002na-Ax
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCn2J-00041a-Pb
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717103410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ry5ONwJwIiG7f4XEeKIIjSHtBGT/JI5E+bwHKaONtTI=;
 b=BbkZobrOGrxxrCZlYJFPYYyZVh04VzcrENjWnZjkxd9W0hE84pVGprDgwgohUN2kZ/FjTx
 vIULGTJhEexqekoeLUKZ4tr5ctq6AWv/yahBP70x85KlBXT8iVUfSSykb2ga20xOnOnXLR
 mmsOPKuu3+PoO1r7OOIXYS1R2SNFSLI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Zu1YU2vHOJeX2EU7sDZitA-1; Thu, 30 May 2024 17:10:08 -0400
X-MC-Unique: Zu1YU2vHOJeX2EU7sDZitA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43fd537e6a6so3243061cf.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 14:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717103408; x=1717708208;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ry5ONwJwIiG7f4XEeKIIjSHtBGT/JI5E+bwHKaONtTI=;
 b=rQgYuah1dnW4aE/z7q9jp8H5HPFT0RCkyfGT3cjjaiLK0JI59aWIUralpYQZT5b3rk
 dQp/AKITtlF9GxDTbxmw6Cdb4yAJAz0xEzTwer7wVZHbKVgFFSI0k24CXtbXd2dpO/z8
 jMHl11PkxVmp7HyppmB1UJIAS5G1ju6YvqMJC5oWOcgeUwkFyiQtoWU9jCfBjas/Be4X
 PA3L52dN0pLISgkJyR4ScJ1AnxyDTli1Qc2iAzJcdORg9Wz/wB3dBo4oYr6t+cNne0eb
 z/aHQZfFwYT5DDWjz6jfCjChDKEbLG8/2mndYdWaMKzDm1OgLY1LeRcKUsMYh6/JXwJQ
 LlGw==
X-Gm-Message-State: AOJu0Yx5Y9Cxh1tizlNiLsRHQCsKNW1JfR96kqKyjbgpa1yDrMu5rUZu
 1ARcqcyhRt3M+Q4jYFtbL772IFEBsVO9HNrtsyTML8SB8aBJmvilnLY77cGPDOyyfNPUCdo/0T/
 GFb3zple+hPiUB+sjpQb1avBY2NU0Op1ELmw7AMpBFLHjJBHkwsHE
X-Received: by 2002:ac8:7c49:0:b0:439:7147:8f2a with SMTP id
 d75a77b69052e-43fe933a6f0mr38498201cf.4.1717103407508; 
 Thu, 30 May 2024 14:10:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpQqAuxwapwqVILLAPWFb6d+a6KobQPIzKYK+HvccgsPKTSo/Kaf7XQbWFZIBGyWViOXiYrA==
X-Received: by 2002:ac8:7c49:0:b0:439:7147:8f2a with SMTP id
 d75a77b69052e-43fe933a6f0mr38497891cf.4.1717103406863; 
 Thu, 30 May 2024 14:10:06 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff25945b1sm1683251cf.92.2024.05.30.14.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 14:10:06 -0700 (PDT)
Date: Thu, 30 May 2024 17:10:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 09/18] io: Stop using qemu_open_old in channel-file
Message-ID: <ZljrLHsiN8XlZi1n@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523190548.23977-10-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, May 23, 2024 at 04:05:39PM -0300, Fabiano Rosas wrote:
> We want to make use of the Error object to report fdset errors from
> qemu_open_internal() and passing the error pointer to qemu_open_old()
> would require changing all callers. Move the file channel to the new
> API instead.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


