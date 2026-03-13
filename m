Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A97105F7A6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13MX-0001nO-Ho; Fri, 13 Mar 2026 10:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w13MU-0001mQ-Aa
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w13MS-0000LU-2Y
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773411569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fye/QUpUoZ3jASXB6WFwGmzYIJXTGaQjADxQ5XwtCZA=;
 b=Kno8l0B97SExxUA1T1qRZzWB6io6X2T1C8c1S+Gazu+8G9pdYXpbU8WB0vQngtvvUBB8xL
 HzPAVBbso4sZvQctk6gEN7CbwjocuM9uipJUBWGTD3yksP6/1wrO1cwAYRSkQYVoi3ZQOm
 CvejIYatCxYfHlQ+mnJERdJNG9RTsiA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-2G2uXHJtOza_ftt6HV4bGw-1; Fri, 13 Mar 2026 10:19:26 -0400
X-MC-Unique: 2G2uXHJtOza_ftt6HV4bGw-1
X-Mimecast-MFC-AGG-ID: 2G2uXHJtOza_ftt6HV4bGw_1773411565
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89a108d17d2so164824246d6.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773411565; x=1774016365; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fye/QUpUoZ3jASXB6WFwGmzYIJXTGaQjADxQ5XwtCZA=;
 b=T9VZ2nJ/RZXgp4gMa/yLzYul5qSKiYLaLX/rnuMXbcZYs/ZTcHtzecs7tIbdUukIBM
 8IiI1GgqufkJI08ge5pTCH4HDzn2AcS6Dt7Acvpg1Bf231k20MsDb0rksooZXaBQEy5i
 qvX00UVOlqRuWLb3veBiMYMPBhF8HkNfxqLY46U/IJdoVlpqqRZb8JaZ9hySbBSfd3bO
 wiA18e2j/s7KlAX/ZiHlYbtLUCBBbKrzNm8pJGq8jSSLEBR8V1huLa2l3jnoJq9zhK9R
 +lAdq7RWZTuknTte49sdVty94BVrsEhCo0ktach97EFtOczxHM7IrXzsGztlFqwL2nGj
 yIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411565; x=1774016365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fye/QUpUoZ3jASXB6WFwGmzYIJXTGaQjADxQ5XwtCZA=;
 b=nUSd7lUKhIf6lDzf343Pq6qzpJCDUyMkYese6Pf1TMNYhP1gwAL7N5NtVmCS/xLz0N
 8E904vC2aRWFzIEFy9W3XQcVsp6jOUjxx+uwlkFnFheEXG1nUxBJXyyRUUVLnQE4K4i0
 SpsusBAj3zajoT5N0th3aCxRfY5BJSsDP22tbLsWH5HWiDjHqHc2EUvvK57qiou1AJ07
 /MnVgYFWHklhwWO87Kf+2GHu60QPyd/KYo5z2VQXDc/shd3VtM5SB6Hw/Q1FmSLjkU9v
 +GL+fcAViieNwBBvozAtBqb2LxcUfjCFJNvEGHon+qdZFKOrI7G2ukMnhbaeRLxpKd5w
 IXtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLB7C7Os2bL9YhxfSBmYHxVp+oc1QbLW/2hwNoxRjA6tEQLqdg15tv1Vu6beAv7zfDai39pNaId6ZC@nongnu.org
X-Gm-Message-State: AOJu0YwfxHrFf9hkkT8lRenOBSCwomJPjhe5+OFkPAwdlAUNMhuuy0WL
 S7rK42zSg9djHar2gs1Av34g7lARuaMsLNyTribVsGNaN0Oc8oFoBetgpaDhFKLi0An9dkoVr7d
 KcHyYt70oTAdZi1/IL5RdQY21j/p3g4HrIieoVjXo5Kk8NJDftUdLHvHI
X-Gm-Gg: ATEYQzySXCUsCBd05QePgUEBmm1ih4js6GV4u10yDW1/T98aWQTxz0uMXH7BjfVtSsn
 uQVkl7uC44bXa8WKW/FDuUNbl/OyYfdw2Q1L4DosXiPnwttoaDA24LF9azh1M6QnQOSBuRE9MPj
 UAw3fnkYWHQfFulPWTVYLEIcZmYDtSJTEgxSrxA1SVyGjyxSw1bw9Ieal8ZYrkRInp7rq/olUbZ
 0YFROHLdmYUPh2BgHSnXu+lTcYJ7/NWbSo+DXY+yP59NRnFYAAV58eyu/ukGenQzlq7GmO4ypdu
 VTI1RZ7awU1S376bmQ9RXiCNRXmmgpsRToTH7aTn488uOsT1vLK0bgqIboeTTKNGUgRAbsrP2aV
 5P3yhq2CqUmS+iQ==
X-Received: by 2002:a05:6214:412:b0:899:ad51:fb64 with SMTP id
 6a1803df08f44-89a81f5bd66mr54782756d6.41.1773411565252; 
 Fri, 13 Mar 2026 07:19:25 -0700 (PDT)
X-Received: by 2002:a05:6214:412:b0:899:ad51:fb64 with SMTP id
 6a1803df08f44-89a81f5bd66mr54782236d6.41.1773411564783; 
 Fri, 13 Mar 2026 07:19:24 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65ce34a0sm57051816d6.32.2026.03.13.07.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:19:24 -0700 (PDT)
Date: Fri, 13 Mar 2026 10:19:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 chenyi.qiang@intel.com, Farrah Chen <farrah.chen@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] memory: Set mr->ram before RAM Block allocation
Message-ID: <abQc65156qHySK1i@x1.local>
References: <20260312063420.973637-1-xiaoyao.li@intel.com>
 <abLf8EW3M7XCBh2K@x1.local>
 <92fcc6f0-655f-5726-1758-b2429911f0d8@eik.bme.hu>
 <abMIgThCxU1gnMqZ@x1.local>
 <9594f358-2ef9-08da-355b-69496c6abb0a@eik.bme.hu>
 <7edbc92d-095c-4cfd-b5d3-102eee092b13@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7edbc92d-095c-4cfd-b5d3-102eee092b13@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 13, 2026 at 11:36:45AM +0800, Xiaoyao Li wrote:
> However, the ram device is affected that is also uses
> memory_region_init_io() which will not be covered by the helper.
> 
> Diff attached below. I doubt it is better/simpler than my original fix
> because memory_region_init_ram_device_ptr() still requires the separate
> 
> 	mr->ram = true;

OK, thanks for the fixup proposal, let me queue the original version for
now.

-- 
Peter Xu


