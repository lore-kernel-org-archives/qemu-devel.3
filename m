Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45830C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdLqo-0003VA-J4; Thu, 22 Feb 2024 22:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdLqn-0003Ny-2x
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:03:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdLql-0000eO-Mj
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708657426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G+qYnq3nvs6PC0Yzuev5p63XAyLXWRAQk1pKLfiMug8=;
 b=huKkFetQjj0luJEXQ/RkPX/hz+fiS8lj5k8LAZVz8R5AMwF6oFz9sPhUUY5KTTMJhOsaT4
 WiJTU/2LeqJh3vOZSs5Q/SFGd5+EFut2lhmvi7/9vTye2y+CIzTeAN75bNMzjSjfjUBMjb
 jrlgLnCw8qXieaVWOJg85uC2N47a6aw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-ffulWNy0Mierb4avm9LvCQ-1; Thu, 22 Feb 2024 22:03:44 -0500
X-MC-Unique: ffulWNy0Mierb4avm9LvCQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29a16254a66so126508a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 19:03:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708657424; x=1709262224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+qYnq3nvs6PC0Yzuev5p63XAyLXWRAQk1pKLfiMug8=;
 b=nIHV94eOQ/2iI5AR7VTp8Ejat+uv+9Cf/Rhr5X8IkPCb9xBD2yWyrMM90Sf9LmyY1U
 qeUn+GuU7b7WZaqnuAuRa79o7V/z9Wknb0CUfH4JCNc6XCljBTf57vvBp0qf6B4aqN5f
 6OISA+wX9pOiRPxYSnVUP8lElDOWxiNI5vvG26mKGxorWbxkLrLsHLyphHyJXPK8PfHQ
 RGBWJMCGZ+/9RuX3MwOLCyrbgJg8/U3yzeOUHCst8a6gtvQ/FYu1RDjf+syUHA3Itu7P
 5mAeZsj6K6fypFGpUEQCOEjOQpivimQL+5QyODyHRPQMT1X9gqf/55wLeQOWoWpr1oD3
 wpdA==
X-Gm-Message-State: AOJu0Yy5QNqkt9Si4JmrzWUj0h3eHIWvUKIzEMHje+Rgz01spHD/xChm
 Kpfnbgd8TrXtriFVXFVq0ZK9tjp3jBkbDxh4+NUPR6UtQAMxtK3PV4662YJJoPTzTlZdRAEWGEL
 SuG8xKqDWqGZPGSk+X6edB6jMLKzu0epZNLutvoym0OeTwYu++/JP
X-Received: by 2002:a17:902:7618:b0:1db:f23f:676c with SMTP id
 k24-20020a170902761800b001dbf23f676cmr732856pll.0.1708657423935; 
 Thu, 22 Feb 2024 19:03:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU2uH3eckbtyUxCSbJ4pg2PXr3jmN5d35nx43Shd7DxEvRD8ei6g/e8qgNt2MEiyyCpOZWbg==
X-Received: by 2002:a17:902:7618:b0:1db:f23f:676c with SMTP id
 k24-20020a170902761800b001dbf23f676cmr732844pll.0.1708657423630; 
 Thu, 22 Feb 2024 19:03:43 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v12-20020a170902d08c00b001d9588f0714sm10674079plv.177.2024.02.22.19.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 19:03:43 -0800 (PST)
Date: Fri, 23 Feb 2024 11:03:35 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 02/34] tests/qtest/migration: Rename fd_proto test
Message-ID: <ZdgLB1KmULCimOQg@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 07:41:06PM -0300, Fabiano Rosas wrote:
> Next patch adds another fd test. Rename the existing one closer to
> what's used on other tests, with the 'precopy' prefix.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


