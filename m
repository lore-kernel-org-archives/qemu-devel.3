Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A933C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtyb-00061x-88; Tue, 27 May 2025 09:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtyY-00061J-5S
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtyQ-0004vI-8J
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748351043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jv5YnKPw0bgkQ99ybognjGNgreUEbk+OwbloSvQAio=;
 b=h+ietowVnvp/lvYvuPCoEwbZdGMaiPzh+JXJogSTwC8YoYPlACbSIDHhJL32b4tRetN5IW
 VAwDHUksoll6xtvemjNVidIe2goeeMdGco7M1DmS4CybhWNfhNZvNF+50PdfiUlVSLvY0x
 0oxhY5NasFiehOJoRXB6Dez5KTi+lfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-A1Goj21gPOGyfCTqKM35RQ-1; Tue, 27 May 2025 09:04:02 -0400
X-MC-Unique: A1Goj21gPOGyfCTqKM35RQ-1
X-Mimecast-MFC-AGG-ID: A1Goj21gPOGyfCTqKM35RQ_1748351041
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so19300425e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748351041; x=1748955841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jv5YnKPw0bgkQ99ybognjGNgreUEbk+OwbloSvQAio=;
 b=Mp3LcqTfwNdf6itBd4UlAdJqAe4uHzfLbvyQb9l3rTvb+POeqwQxI6pFjeAAnO7gp+
 5gfMvlnKI0jTUE7UEo9EQQblJfjYrxTGKwp0K4b356Bs8dwjDZjEuvFVs+uG5krFna1a
 Mv56s4rZJRKQen3qMexEhL5rfPz6FUQowzF2Ev4fXI5JEwySzRX3G7ZFAB7r85QmCYp3
 DCWRhB+D854GIks/KgGyMQbzUH/wM4DH3XasZ4+wZfCvIBuyS4ZDhI2+RvlPtuHS+tZQ
 K2Dtj4nx/e/MdcR8kwV7hEOPBX/f1LQtbiXHhbaR3Fh4kzqK+k3KRKaS5UqxqrxPOKHw
 R1Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7AP+ogxz4xxxTBSKeVLaSSYLt+KPiJOmYjdr7DsPdhvuB77E5lxv4nIjuVbliqaK7j3u+GCU1ILkq@nongnu.org
X-Gm-Message-State: AOJu0YydSYElVjmL1LAQE4GOgbTG/C7m+mjBbYxKIwSSWYne6EIcz44L
 mClZ3O6i20Kcs/h5gavdQR/MBGJtdQjrxhVTL0YlZ3rmtC9p24cKcW4jkqDVE9wxakgfmsxv8d0
 /iEMHmRfLaS49B/adZNa282fQeUUjvBE90tzeTDz+SCFB22Jez5o3DfPj
X-Gm-Gg: ASbGncsDAfxbK4XesL/Ybz8F+OLE2cfbFYAqinQ1+mHhYehA6zpNjAPIToDkWJJQ1Gp
 YCtzpi6F6C6sdOyp5bxE219js30YyYB2XS/+MGd7oca2BfTR0weIdRjZvLRk/tffbP0KdD2Mcpb
 /HhjDEXjt+9hvT6lf5mKW5FyUZEZllSicJp4/wRG/HsSIASPwfBAmyam7q84p3jYFbDO5Ez7o+E
 n5VzBLAdsLLybr3um0fh426vR9T+tCZMfjRQAYDlhsCPNggqROxAYsfEKFvIwA1ydijrSXD+zDz
 kLJoAvBYYJWTCUEjV9LxG+eu2/HBemRx
X-Received: by 2002:a05:600c:648a:b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-44c9141ab42mr129018225e9.2.1748351041079; 
 Tue, 27 May 2025 06:04:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGygNu+IYItu+LRzcSI0psE4MrQWx5AHjAShOjnRGSgvcGdTCLXCg4LURFTpYi/aoc5orxbFg==
X-Received: by 2002:a05:600c:648a:b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-44c9141ab42mr129017335e9.2.1748351040342; 
 Tue, 27 May 2025 06:04:00 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44804e89c42sm277960545e9.21.2025.05.27.06.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 06:03:59 -0700 (PDT)
Date: Tue, 27 May 2025 15:03:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 08/25] tests/qtest/bios-tables-test: Prepare for
 changes in the DSDT table
Message-ID: <20250527150357.03bfab2c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527143816.39c0dfab@imammedo.users.ipa.redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-9-eric.auger@redhat.com>
 <20250527143816.39c0dfab@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 27 May 2025 14:38:16 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 27 May 2025 09:40:10 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
> > From: Gustavo Romero <gustavo.romero@linaro.org>
> > 
> > This commit adds DSDT blobs to the whilelist in the prospect to
> > allow changes in the GPEX _OSC method.
> > 
> > Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>  
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
I take it back,

test with x86 enabled breaks on microvm,
so it's missing some DSTDs here


> 
> > ---
> >  tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index dfb8523c8b..abe00ad4ee 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1 +1,6 @@
> >  /* List of comma-separated changed AML files to ignore */
> > +"tests/data/acpi/aarch64/virt/DSDT",
> > +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> > +"tests/data/acpi/aarch64/virt/DSDT.memhp",
> > +"tests/data/acpi/aarch64/virt/DSDT.pxb",
> > +"tests/data/acpi/aarch64/virt/DSDT.topology",  
> 


