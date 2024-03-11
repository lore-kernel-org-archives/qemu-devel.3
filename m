Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C7BC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjn9X-0004ZF-Uv; Mon, 11 Mar 2024 17:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjn9W-0004Yd-1B
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjn9U-0006n7-64
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710192342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30ukH1T9AXq73bHEFxkktuSDc1aa9v3C+xAUXhg5HZE=;
 b=FVCKwBLyV7BebqUVriiqa8T6z8/pBu/8qN0vx2rIL1sa4GZ8XzJ07YFmepSCKN4vmUnfA6
 qKy5B/VkWZeMHuIhEZ8c0smE8sNudAJNZKqN0wkb4wwc3657mdI7n0+4zzLJ0MPNLmJuxM
 wN/qEVFoZDCOzJ7p/GafcvCGNkgrxvI=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-iPt7h8xoOxuP-TrbR1AOkQ-1; Mon, 11 Mar 2024 17:25:41 -0400
X-MC-Unique: iPt7h8xoOxuP-TrbR1AOkQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-21e4604101bso1582625fac.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710192340; x=1710797140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30ukH1T9AXq73bHEFxkktuSDc1aa9v3C+xAUXhg5HZE=;
 b=TQHB9u39IrG6tSMTCxewWbpzzIvk13ev3SiWHopI0JZqVwLkMA2d3bL+kSEg5h7/+O
 nuGWkGbwEAUhn/wK4TSYvPuY8MBEgKZHepvrHxi5LHWW0iRXtEGZH+AJXRWqz8Wfcyb3
 bxTUJ2HI6RA1YBfTbeP85mCrSj/b58NVslNdPJ9eE8pXeQie3rG+3PXXaNCHNf+v9Q5v
 C16ShvhEcFOJNIm2LDfEsEpcbutyU8Dj7NBEDOF+ShK1FAtJ0cRgWKkAwQZzEiFdvfXb
 dYPl1TPvPXRjhKe7IZRJEUwjuP+qXbePSK4yvi0PKW5B1GfsU+XHfkpZTac9evBJXSpJ
 t8Kw==
X-Gm-Message-State: AOJu0YxNUE/IP+KprN00EuVxQEckYeHK8mCiFmLkvSBcsq2CI/3XDZG+
 eBNNcg4LHj5jnaS6vxI9gb4zpsbwqCh6CAFRlX0yu3O6PiTIPAkPh+9VefqVwJ5Fb/xz0Frawaf
 RZuvbcXsjE87sdiErQJmPfE/a+/T4LkooLGlFifPIEmgkuNN/w3gj
X-Received: by 2002:a05:6358:707:b0:17c:1bef:408d with SMTP id
 e7-20020a056358070700b0017c1bef408dmr8012552rwj.1.1710192339814; 
 Mon, 11 Mar 2024 14:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7K8wkd+El2hTYzyV8Ofgud00ATM+AxScvC/RDefHArdqh1cEgBjPPCfOpC1qO1Oi5kznntQ==
X-Received: by 2002:a05:6358:707:b0:17c:1bef:408d with SMTP id
 e7-20020a056358070700b0017c1bef408dmr8012511rwj.1.1710192338745; 
 Mon, 11 Mar 2024 14:25:38 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 fp37-20020a05622a50a500b0042edc381599sm3097741qtb.1.2024.03.11.14.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:25:38 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:25:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v4 0/8] qtest: migration: Add tests for introducing
 'channels' argument in migrate QAPIs
Message-ID: <Ze920doZYn99aLCn@x1n>
References: <20240308205951.111747-1-het.gala@nutanix.com>
 <1db9b780-a83d-4794-8ddd-1547615cdd9b@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1db9b780-a83d-4794-8ddd-1547615cdd9b@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sat, Mar 09, 2024 at 01:11:45PM +0530, Het Gala wrote:
> Can find the reference to the githab pipeline (before patchset) :
> https://gitlab.com/galahet/Qemu/-/pipelines/1207185095
> 
> Can find the reference to the githab pipeline (after patchset) :
> https://gitlab.com/galahet/Qemu/-/pipelines/1207183673

Het,

Please still copy me for any migration patches.  In this case Fabiano is
looking it'll be all fine, but it will still help me on marking the emails.

Thanks,

-- 
Peter Xu


