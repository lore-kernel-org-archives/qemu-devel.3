Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0362BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 10:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwJH1-0005mv-P2; Mon, 15 Apr 2024 06:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwJGx-0005i1-RM
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rwJGw-0003CG-45
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713175748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1reYJAwUlWkTrDV+/iYxq/YBSqtYOieZLKjl187mNv4=;
 b=WW1LLh8a1qZK5k8ItH2pWx7Yq/caRpPprE6aKLIeCN9d43Ew2jPz8Woc59M6fyLO9aRFOo
 DZ4uPGWXYDka2rkEqTkbdECi4DmRjnqTn71JcyY89tYoh99uT8YlQJfUO3w1iX4ipVAFLu
 PCoGYxoTpWdPw5glxObokbVCGLfLrTc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-4KJBhGuVMRK_Eaq6ifFc8A-1; Mon, 15 Apr 2024 06:09:06 -0400
X-MC-Unique: 4KJBhGuVMRK_Eaq6ifFc8A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343ee8b13aeso2575127f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 03:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713175745; x=1713780545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1reYJAwUlWkTrDV+/iYxq/YBSqtYOieZLKjl187mNv4=;
 b=e2hV5xa2nFrayBgDZKe44YgAjM84j1ibDa+x1HX0s6QOooBIsUVA3SAkEdCZ6xVxry
 n3gMCneFLN8Pim/I9HP7eai01n0GJiP5CTLBBcAMZPXvDiEDaTU3zPfVNmpp41k6lZIU
 QDxeBTDqTrDOZqE492pLLK6axNHQiC4acF7kE79o6qvw6e9sjbfahYADAgMDVePKAnEc
 ik9vDdU1gf1cliWG9LqDYRgjYFw0PTJdNJG8fwlAjEIuKq04D4OUDiZNML+G4gEkT3rE
 e226iFhTHQVTUAl7KUAFTH3Q2Tj06oDvayD23fGSetgG0KU4bYB0SfQLWXxnaJNdgMkS
 JgUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvmeuFvKsT+1IPEwnXDp6f6j9RybwYc3ZEKeTtgs+hSCa2hxV6Dig4pYXfvXQ8f/spf7233hSDQO8avmO9kvCdYwXqXfM=
X-Gm-Message-State: AOJu0YzJgLJZ/o2z9V7J5Qi/LRQCZYsAodmU59Ysngc0dV52iKp601sv
 HbjODfyzP44nFf4CvhH/Mh7N2WGXFnd2OF7QRAzjoRYQah8D7t/Md85DpqqcDlqs+xF5KubwG5e
 8+Z51vISR089bJ4GCBfMzHKElwS+ltwrraWyuNqC4NwhbA4xyjQjj
X-Received: by 2002:a5d:5102:0:b0:341:dedd:9726 with SMTP id
 s2-20020a5d5102000000b00341dedd9726mr6755767wrt.3.1713175744947; 
 Mon, 15 Apr 2024 03:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG3BlvsitLAriRPjk3X0JvfqeeZIVqQsC2XWaLnGLuuwCHH6mpAh9ajXuxDNYP7WgrRJsoPA==
X-Received: by 2002:a5d:5102:0:b0:341:dedd:9726 with SMTP id
 s2-20020a5d5102000000b00341dedd9726mr6755744wrt.3.1713175744457; 
 Mon, 15 Apr 2024 03:09:04 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:a95b:a91:79d:72cd:ca48])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a5d4cca000000b0034698307cf8sm11647608wrt.15.2024.04.15.03.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 03:09:03 -0700 (PDT)
Date: Mon, 15 Apr 2024 06:08:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, isaku.yamahata@intel.com,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is
 not disabled
Message-ID: <20240415060844-mutt-send-email-mst@kernel.org>
References: <20240403145953.3082491-1-xiaoyao.li@intel.com>
 <20240415094450.268675-1-pbonzini@redhat.com>
 <20240415054955-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415054955-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 15, 2024 at 05:51:56AM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 15, 2024 at 11:44:50AM +0200, Paolo Bonzini wrote:
> > Queued, thanks.
> > 
> > Paolo
> 
> I actually had it queued too - it's not 9.0 material though.
> If you queue it don't forget to tweak the commit log manually.

oh and then you can add my

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> -- 
> MST


