Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A6BC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 21:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEbGU-0000Wp-2B; Tue, 04 Jun 2024 17:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEbGO-0000UU-7G
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 17:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEbGG-0005LQ-Eb
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 17:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717534802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Cpc7IFjk1BQk2P3eQhLXtN1E2+HZNERO9loUC5Wat0=;
 b=HkFncog+eArI7RLyi8b3vFPPkhuINP72hqCyM9lXtmIKyajYXpXMhWyBxx+ZnE5UHbe4js
 0gR2N22LbPq/CmXwpgW1g5gRsvu4FZ4cbsEyBVjBWvzLw8DfA/vPA64/Zq8kJnGqF8QO8R
 rvSS395DdQ85CRWDnNRTZDSSrmTIMNg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-PA65m0AtPGOJiwtAUpueFw-1; Tue, 04 Jun 2024 17:00:00 -0400
X-MC-Unique: PA65m0AtPGOJiwtAUpueFw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ad5ebfaa68so17055976d6.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 14:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717534800; x=1718139600;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Cpc7IFjk1BQk2P3eQhLXtN1E2+HZNERO9loUC5Wat0=;
 b=auKdyvaWBRQQVp5deW6Awg3D24bqqTDj+hMSTpCWO7yP2py36mZhwQ9w9feHadCWMS
 GTU83zJAK42XcuwMpvWrtJXrj1DPjCrLbtLCph8li7nT9/Lfc7gTbxv/X5kOjs0LNoBN
 1CIhJTNDEPJjJytRb2E0VnWRxeN7JueTrYUS5+bC0CC/jTGJHWvWldzpVDP0nIulTDU7
 3KKFQJ8RIg/f5/X1LXZVYYcDsKp55zREGqPIrgr9NfCYuX3GBmNh+RGQmIKW8au4pm4J
 i5GkoQ1tjmrTUVkByhcivV47a1LoXBrniwc3VDKT0cvUgqmFLsWISHW0Y2IcYKBj18wj
 rZyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGd9aHhAAR7uieqzT5yUHMqF7rcIyewqNkLO/47BnrtDj3q2MW0hs4ef7sO1bm4SWRu+tTbFOOdKhx5Gn6oEWcprGRRt0=
X-Gm-Message-State: AOJu0YxSUTSrFegX9OxMUTYevvfFCMI4wweIKrh6/adXaw15EnqbSCy2
 9ejCV44rmJ1PZFw/TFIsDhep1K+aK/u85XGXnr68TIBqyA1cs+lgDDDvtH5+v4EIob5HTpUBbUA
 TMeOvvyfe2fnrJqUuubA96I2Phz8+f0dezDKxcobnZ9rhizycKXa4
X-Received: by 2002:a05:620a:2886:b0:794:edc7:1566 with SMTP id
 af79cd13be357-795240df187mr49496585a.4.1717534799921; 
 Tue, 04 Jun 2024 13:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFClCt7GUi+NhTV+OJUKLF8VC0dTTUpjQJnIQD2vkqfF7z+T8+mIfn1C18jEwb/RNewejKf5A==
X-Received: by 2002:a05:620a:2886:b0:794:edc7:1566 with SMTP id
 af79cd13be357-795240df187mr49493085a.4.1717534799349; 
 Tue, 04 Jun 2024 13:59:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79524c12485sm8170485a.87.2024.06.04.13.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 13:59:58 -0700 (PDT)
Date: Tue, 4 Jun 2024 16:59:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: farosas@suse.de, yuan1.liu@intel.com, qemu-devel@nongnu.org,
 linuxarm@huawei.com, linwenkai6@hisilicon.com,
 zhangfei.gao@linaro.org, huangchenghai2@huawei.com
Subject: Re: [PATCH 0/7] Live migration acceleration with UADK
Message-ID: <Zl-ATAeH-hZ6IFHz@x1n>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 29, 2024 at 10:44:20AM +0100, Shameer Kolothum via wrote:
> Hi,
> 
> This series adds support for UADK library based hardware acceleration
> for live migration. UADK[0] is a general-purpose user space accelerator
> framework that uses shared virtual addressing (SVA) to provide a unified
> programming interface for hardware acceleration of cryptographic and
> compression algorithms.
> 
> UADK makes use of the UACCE(Unified/User-space-access-intended Accelerator
> Framework) Linux kernel module which enables hardware accelerators from
> different vendors that support SVA to adapt to UADK. Linux kernel from
> v5.9 has support for UACCE and SVA on ARM64 platforms.
> 
> Currently, HiSilicon Kunpeng hardware accelerators have been registered with
> UACCE and the Zip accelerator on these platforms can be used for compression
> which can  free up CPU computing power and improve computing performance.
> 
> This series is on top of Intel IAA accelerator live migration support
> series[1] from Yuan Liu. Many thanks for doing this.

Just looked at the IAA series too, I didn't read multifd-*.[ch] much on
both sides but both the series look pretty clean to me.

Thanks,

-- 
Peter Xu


