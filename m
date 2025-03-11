Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE65C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Tm-0001RR-Ct; Tue, 11 Mar 2025 11:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ts1TP-0001DA-V1
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ts1TN-0007S5-RR
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741706689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LAJ3DY5BOA4zXT3h54fG3oDbwrEXOgXCIakN900wo/Y=;
 b=X22OQ9XtitPtSeqgCMWu/GMFObd0EhUQA/RTrCvIVdBjaX8bAresn40SBraO3H2yKw1gNI
 +wwBjGtr5MIjo4KU5wwmWIT3/j6EGGfehu3/Yi2JLvpq6rW+JgPerponnr2OXrPC/1vVaI
 QID+tAxRL9fEDx7CrL0ZOMBk10uQ8HI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-1jTd9HBHNuWgLzbibGYkLg-1; Tue, 11 Mar 2025 11:24:46 -0400
X-MC-Unique: 1jTd9HBHNuWgLzbibGYkLg-1
X-Mimecast-MFC-AGG-ID: 1jTd9HBHNuWgLzbibGYkLg_1741706686
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912d9848a7so2482359f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741706685; x=1742311485;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LAJ3DY5BOA4zXT3h54fG3oDbwrEXOgXCIakN900wo/Y=;
 b=tKArqrVMiAssi0mc/6jPd0oMqThVZ9wwK1Z0HjWYocjMZklr+lJqjG++y2FN87Shii
 hJAqJMQKhSmOC+1tsHUifNyegTYPMSmlSUJnyr+dDev0ZqktvsJlWJEoiiCnv518cDHd
 pBnztP4LrbubvKYc9nsn1stPvWaZn3GdHRDLzzR4U52Ncjnjg3PFWKcbpLtV3t9/B6Te
 yRvDG1BtiYelhdVscPEGNUVYSL49MNhOPentSNVAi65Y2zrFfhEhu3GHWElxXWfJjdBI
 kKujBDWq8kFKD/luVAejhr0BPeLYD9Vz0a2PwNaHx1fPIxnO7arFxRfqX9Q4MxYn+qbe
 SVug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnczGa+og/vQ0O4AGy2fVEcTfXAM7WjN2CefMrfIokWINuEgQU6nz76krUgO9CIWuUPjEMXLwnwjkz@nongnu.org
X-Gm-Message-State: AOJu0Yz93RRAlXjLTAnixUXGu+TX3YRr0X9qeCSjCnSXsFufNnuo6JSp
 hVZqvDA5fsJrW3z8jlY4C+IBJdz9pdu2A38Lf/bZnDsW2dgiGIgGYO8tab6aGO/+Ki1ixOo5nzV
 hj+NZa8wDa9k89wmY/i4bxUIC85pMJNKZRpU6mqNBfAfbSKgY5z0CEM8iHdWV
X-Gm-Gg: ASbGncv4FsbO8Q84rsGepruXPDTwV0Gnmtt+figSSlAnp2ZF8+mrf1H+v/GroRINciG
 uuO4Mq+aV4uBPs5aQVqL0Cx4ZDVF4agx0t1qzes1xXO9h11h/Vga7bZGk9OdSDW7jXc6ed2z3Jn
 ZVA+DtFqCZ9MlFvpnEDei9zca6OPqucRJEQrOhV9rPJua0ZG3U7OznLocZif9wL7Jj8tJFN8Iga
 H0JP0noiEAOkjTYFlLHOjU0qQGsO1+1ABPyIMVS8+wi8PJ9+eNKJ44dirwm3+HnokEmdXcxEP3Z
 CcUv5qMVIJWi5X9htLXCceorEJZ2uG0qEqUF4KUBC/IU4e8=
X-Received: by 2002:a5d:47c8:0:b0:38d:b028:d906 with SMTP id
 ffacd0b85a97d-3926d1238e1mr5848642f8f.21.1741706685686; 
 Tue, 11 Mar 2025 08:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8fVM/1gUx36KW1Fh1UEtjF+pkgULsS51A8X2cRwFgsQ+hUsqVtTxlRrZaGlZcMc0tZ4VcGw==
X-Received: by 2002:a5d:47c8:0:b0:38d:b028:d906 with SMTP id
 ffacd0b85a97d-3926d1238e1mr5848614f8f.21.1741706685298; 
 Tue, 11 Mar 2025 08:24:45 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-149.web.vodafone.de.
 [109.42.51.149]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb79cfsm18468517f8f.10.2025.03.11.08.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:24:44 -0700 (PDT)
Message-ID: <39ad1fef-f5cc-44f6-be4d-84a597b3f9f6@redhat.com>
Date: Tue, 11 Mar 2025 16:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] tests/functional: Convert the SMMU test to the
 functional framework
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250311104920.364102-1-thuth@redhat.com>
 <4b7d75f1-12df-44ab-9435-df517beff716@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <4b7d75f1-12df-44ab-9435-df517beff716@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 11/03/2025 15.00, Eric Auger wrote:
> Hi Thomas,
> 
> 
> On 3/11/25 11:49 AM, Thomas Huth wrote:
>> This test was using cloudinit and a "dnf install" command in the guest
>> to exercise the NIC with SMMU enabled. Since we don't have the cloudinit
>> stuff in the functional framework and we should not rely on having access
>> to external networks (once our ASSETs have been cached), we rather boot
>> into the initrd first, manually mount the root disk and then use the
>> check_http_download() function from the functional framework here instead
>> for testing whether the network works as expected.
>>
>> Unfortunately, there seems to be a small race when using the files
>> from Fedora 33: To enter the initrd shell, we have to send a "return"
>> once. But it does not seem to work if we send it too early. Using a
>> sleep(0.2) makes it work reliably for me, but to make it even more
>> unlikely to trigger this situation, let's better limit the Fedora 33
>> tests to only run with KVM.
>>
>> Finally, while we're at it, we also add some lines for testing writes
>> to the hard disk, as we already do it in the test_intel_iommu test.
> 
> for your info it does not apply anymore on mainline after latest appied
> functional test additions.
...
>> +    ASSET_KERNEL_F31 = Asset(
>> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>> +         'releases/31/Server/aarch64/os/images/pxeboot/vmlinuz'),
>> +        '413c7f95e7f40cfa3e73290ffae855c88fae54cccc46123a4b4ed2db7d5c2120')
> the hash seems wrong for the vmlinuz. I get
> Exception: Hash of
> https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/31/Server/aarch64/os/images/pxeboot/vmlinuz
> does not match
> 413c7f95e7f40cfa3e73290ffae855c88fae54cccc46123a4b4ed2db7d5c2120

D'oh, I got tricked by "wget". I used wget to download the asset to manually 
calculate the sha256sum, then manually copied the asset into my cache to 
avoid a second download.
But wget apparently unzips the kernel:

$ wget 
https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/31/Server/aarch64/os/images/pxeboot/vmlinuz
$ sha256sum vmlinuz
413c7f95e7f40cfa3e73290ffae855c88fae54cccc46123a4b4ed2db7d5c2120  vmlinuz
$ ls -l vmlinuz
-rw-r--r--. 1 thuth thuth 25885184 Oct 21  2019 vmlinuz

While curl gives the correct results:

$ curl -O 
https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/31/Server/aarch64/os/images/pxeboot/vmlinuz
$ sha256sum vmlinuz
3ae07fcafbfc8e4abeb693035a74fe10698faae15e9ccd48882a9167800c1527  vmlinuz
$ ls -l vmlinuz
-rw-r--r--. 1 thuth thuth  9027813 Mar 11 16:13 vmlinuz

This should fix the issue:

diff --git a/tests/functional/test_aarch64_smmu.py 
b/tests/functional/test_aarch64_smmu.py
index bba8599401c..4f0492ca50d 100755
--- a/tests/functional/test_aarch64_smmu.py
+++ b/tests/functional/test_aarch64_smmu.py
@@ -123,7 +123,7 @@ def run_and_check(self, filename, hashsum):
      ASSET_KERNEL_F31 = Asset(
          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
           'releases/31/Server/aarch64/os/images/pxeboot/vmlinuz'),
-        '413c7f95e7f40cfa3e73290ffae855c88fae54cccc46123a4b4ed2db7d5c2120')
+        '3ae07fcafbfc8e4abeb693035a74fe10698faae15e9ccd48882a9167800c1527')

      ASSET_INITRD_F31 = Asset(
          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
@@ -165,7 +165,7 @@ def test_smmu_noril_nostrict(self):
      ASSET_KERNEL_F33 = Asset(
          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
           'releases/33/Server/aarch64/os/images/pxeboot/vmlinuz'),
-        '0ef9e34f80b49fa2ac098899b27075e95c11d5b646f6ca4df2e89237a40f9e4f')
+        'd8b1e6f7241f339d8e7609c456cf0461ffa4583ed07e0b55c7d1d8a0c154aa89')

      ASSET_INITRD_F33 = Asset(
          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'

Sorry for the confusion.

  Thomas


