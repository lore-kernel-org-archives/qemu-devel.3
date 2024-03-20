Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE67C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrbm-0005Qh-0b; Wed, 20 Mar 2024 04:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmrbk-0005Mg-Nc
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmrbV-0000LM-GN
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710924437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=M4dmy5P6MzwpdSkDcfD/MyK5EonWv8r2KCb25J/iSehgHwQCJRpBRfwEmURIAQUGnI7qHa
 lpFDM4KKTdpkCdIPMRw6t356rWsP4qKsTW4N93tgMcnmN4hp+p23HkcScB4tgETWGmrSKj
 swFCN59+ChVLf2hbVwUbcURAzMEwlww=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-ALz6aagwNmW7wYKVF94utQ-1; Wed, 20 Mar 2024 04:47:14 -0400
X-MC-Unique: ALz6aagwNmW7wYKVF94utQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5684bbeb4b9so3371750a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 01:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710924433; x=1711529233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Zb2qWfObHm7pdlDfzhQXrj+P4G6SU+tXaErFEf1tAT+NRZA4ueW5iVWp5ffqSeRNQj
 5UZvgWfIfK3VzBnvJOvhq2v8haXpRH5nLdgnaRuHA+K6sfieVGghTbYEzgUOpWm/EunK
 NLK1eyJ84QgzSNZgI+rOB5PSrqIu2mJ2Bh+CXLYM9xvDDj5rPLjaev0xm1/UFDqB5Qk2
 qWWl6WRyF5p/tIcWGlkfYIe5XUD8do0EVBA5DIh80cT4oO1om0IZzBK757erl5+BNDgk
 HcNsX5dLS//KUD7+7RzarLbrRsdWadCUXvJbI4cKQpZ00J1TtDECep2xPPuF/sbeHRlM
 Oc2g==
X-Gm-Message-State: AOJu0YzM6Jvm0Q7Fp/e9J2ZT3Yn8EpWi1RmvFQXB1xLYSWDL26i4EMe7
 r2KA3BNpUnBJk1ZldKJWBpcLs/EwAUmVMdjIUgWrPJf4KqszEIIsVQ63+Pyyh0A4TQrg7JOwVvq
 J6irNPkGXHqjltto+Flg4kzcJDAQR4wf53l/SvWhgDI0bgCYDrYQG
X-Received: by 2002:a05:6402:4016:b0:56b:9ef8:f630 with SMTP id
 d22-20020a056402401600b0056b9ef8f630mr2260625eda.2.1710924433570; 
 Wed, 20 Mar 2024 01:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTPJKaQ33jCPjePWjG8d5PWntLHejYyzd2YoEMdZzvFMdR5VDK8gxaW53KsriIWs8HeFVSjw==
X-Received: by 2002:a05:6402:4016:b0:56b:9ef8:f630 with SMTP id
 d22-20020a056402401600b0056b9ef8f630mr2260613eda.2.1710924433285; 
 Wed, 20 Mar 2024 01:47:13 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 p8-20020aa7c888000000b00567fa27e75fsm6652350eds.32.2024.03.20.01.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 01:47:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 alex.bennee@linaro.org, armbru@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2] target/i386: Revert monitor_puts() in
 do_inject_x86_mce()
Date: Wed, 20 Mar 2024 09:47:11 +0100
Message-ID: <20240320084711.1036811-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320083640.523287-1-tao1.su@linux.intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Queued, thanks.

Paolo


