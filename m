Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E504CA0ECD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 15:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulUtq-00040E-A1; Mon, 11 Aug 2025 11:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulUta-0003t2-2j
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulUtV-0005hD-6D
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754927822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9J1hpDjsPw1YaBswWxjVJ3eFEIVpobNqRu0ldBuVFQ=;
 b=VGGorZPxL9gFrOYOkrEuiV6a3qVKDNc9JxdOM1wk+vAqirrvBp2GlGByOXhSJfkJsH2S+w
 sGwsOgsOUOMmm+baC16/W3CimEL2gRmR4UsER2xIUeDVVb+MPcppbsieo1orXotja+0zdy
 9+1SGRtKfasXnuqtsp2z+h0Xv4NviL4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-sDg4JKLzPUymRkZzySn9LQ-1; Mon, 11 Aug 2025 11:57:01 -0400
X-MC-Unique: sDg4JKLzPUymRkZzySn9LQ-1
X-Mimecast-MFC-AGG-ID: sDg4JKLzPUymRkZzySn9LQ_1754927821
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b06d08d61bso134512061cf.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 08:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927820; x=1755532620;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9J1hpDjsPw1YaBswWxjVJ3eFEIVpobNqRu0ldBuVFQ=;
 b=UY3Kc2FT01Wl+2u36+/lQ1JhdRvXIXcK5a4frF6pGblvd4I1U4dN3aiwqn2/JiTF9D
 iAl82LEQeeqdsmDtPf6OP6iJOsPzRDvZ7e0oi9GgOqOVyhxlvkFcto+Zvae8hlf3hM3g
 /XmzUi8YW8T0sSBBKy6DG4IlEdSlRWRjPGcfT1ZZw0MgB92yNCBBlhXwHWmwYaQ4S6Jo
 mXU+lsB3zTDnbbqHekY67v+etwn3hKvYB4I1+xqGyzp5781Cvu8yaoHoc6f6JwoRQ5ZH
 BJ0eY8G+ZvaTgWq/k569jUEdwxH8inpGFSGgzNCM4ecaXUF2szoYlnH9Jwyz09mckpjI
 PUsg==
X-Gm-Message-State: AOJu0YxrpQlbTeBguY4vyms3RxRN4PaqYryr3U295khZIgUbC22Q1WKu
 fHHLfH4hoq+RpWka6p9kcDlYzZXgQn2zQSOxZSPctsvq0A+B2xU46OW7fHDgKxCL3Ui/GstarFe
 UKiv1i0bMONiBfbTT/TuGM33dDHStoHs7XWYn0kooJhH9Yly8+XU5N/B2
X-Gm-Gg: ASbGncvz94wN8V58XhAasghWsECQXKNzfUeT3X3ImImguK64diT2LLMqey9MkbMaT7S
 DJkfUsl9q1TwtSYfJgr3gIu5PxJVj7icGwFS9rO0uYbGPWLs1AxTlJF6vXrLLsyoMwVUkkWgmDn
 9WaV6GRdwOi5cVpTiQVtSmtJdHSyKRioBxPejAyvO8BPYNtpY1BOOR7vCgmpIf6IHO0SaRz251+
 L7lCDqbyLP1m1oUltv/hi+hqVJFnqNAvBVufMIv7DlZ3XVw5DkbINklvR7tkbvamJHUCcv4IEfR
 0yFdDmllF2+S9QNg6+a8rvLVp0OLad5b
X-Received: by 2002:a05:622a:4818:b0:4b0:af6b:b949 with SMTP id
 d75a77b69052e-4b0ecba2eb9mr207891cf.6.1754927820468; 
 Mon, 11 Aug 2025 08:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnu25jW9Ou7dXzbIwLa1zWZPXmgnEDNbk6q+TfLzsiQ+bxWMeAyfJOYQOrDVeOxkq2jjHVXA==
X-Received: by 2002:a05:622a:4818:b0:4b0:af6b:b949 with SMTP id
 d75a77b69052e-4b0ecba2eb9mr207441cf.6.1754927819832; 
 Mon, 11 Aug 2025 08:56:59 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e832a3cb8bsm512468385a.17.2025.08.11.08.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:56:59 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:56:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 david@redhat.com, philmd@linaro.org, mtosatti@redhat.com
Subject: Re: [PATCH v3 04/10] hpet: move out main counter read into a
 separate block
Message-ID: <aJoSvxMwms_qDS8-@x1.local>
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-5-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808120137.2208800-5-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 08, 2025 at 02:01:31PM +0200, Igor Mammedov wrote:
> Follow up patche will switch main counter read to
> lock-less mode. As preparation for that move relevant
> branch into a separate top level block to make followup
> patch cleaner/simplier by reducing contextual noise
> when lock-less read is introduced.
> 
> no functional changes.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


