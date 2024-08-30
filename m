Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F868CA1004
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 15:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk3e2-0001o4-Qz; Fri, 30 Aug 2024 11:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk3dv-0001ll-Nj
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 11:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk3dq-0008Un-Vg
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 11:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725032065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=celgQTF4PY6uut4xBsKKnizuI3RMUI0DLuWoPXq+MXA=;
 b=HSjPYttKjyUprCMPRPpAsA0NR0pAssuQykBuCVmLp56xko0jif+tRsZwAyUweA0UTAPMHY
 zzRDMjXqvfAC+V6lJ/vIOwKu3Hu/b0Rbo1PkSjWyqgWGa9rTYZUrUwsJ+y/fj9GRm3hbg4
 +t4UnbWHnqA+sn6IEvY4ERDw0ED6Fr4=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-75MHbiyZMhSeVgKjv9En7A-1; Fri, 30 Aug 2024 11:34:23 -0400
X-MC-Unique: 75MHbiyZMhSeVgKjv9En7A-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-277b92cfb91so557918fac.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 08:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725032063; x=1725636863;
 h=content-transfer-encoding:autocrypt:subject:cc:to:content-language
 :from:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=celgQTF4PY6uut4xBsKKnizuI3RMUI0DLuWoPXq+MXA=;
 b=ITNCvumyZKJtlEAYbhQ6WJaZGOwIk7ZfXyX26N60MQIC0y7j1dDaO/++ryA6Pa1Gb3
 PXfEutHAlKCipnUPG1izwiLTbXKPCSmMxPUgVVOmJzym5peR7qPvtO254Rm8x8DHYJff
 hvd+QPleanADPk0bytYZ+NBaKC82U2PgsmlgcKhb4M74cnd4+fXj/hfANzFOzMxt80Sd
 y9+hUAFi2ohuJFDyIbmFQdrQxgQo3bt9N1B+9DsjbfwMt4oTgNCXhE5uYhwkSBY5Uf9D
 LKR08ugFokwycrQvNTcFxjxJCWhcKg9sZKDkc/PoseMYGtlLp8tq2HJgdsArceyiTDTq
 t+8A==
X-Gm-Message-State: AOJu0YwyHMOBIqVPEjPLKPmsrqsYCrw10+eEHfOLpIaAwyjQNxIBzxoN
 8892mqnoY8qlwLLMnV1MbgmFuGCrm3hpU+gnXo5vLtWQeqGd68d7OirypGKKA6WghVcAZPUfewt
 0miAyazvTJf1zL45EgCTLiwj7mvZnvVUxlWmc3YGpQBgjNuEAD7wzMwI/7iSnguRTfBaLLeHP0s
 jVXqivwz9YjvvaR0Uru9iDYUmPlvV4EcBF
X-Received: by 2002:a05:6870:2104:b0:260:f883:95f9 with SMTP id
 586e51a60fabf-2779035c400mr7584785fac.42.1725032062981; 
 Fri, 30 Aug 2024 08:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYeaig2bKnau5g5wf4AcvFuwvR6B1HsLqPWr0opqSx2ZoJegr4jx6ZPeXM0J5wm9dxWtCtVA==
X-Received: by 2002:a05:6870:2104:b0:260:f883:95f9 with SMTP id
 586e51a60fabf-2779035c400mr7584768fac.42.1725032062710; 
 Fri, 30 Aug 2024 08:34:22 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-179-35.web.vodafone.de.
 [109.43.179.35]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806bf71aesm153023885a.20.2024.08.30.08.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 08:34:22 -0700 (PDT)
Message-ID: <747e3626-e4f4-47e2-bdfa-ca047f9f8443@redhat.com>
Date: Fri, 30 Aug 2024 17:34:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Bin Meng <bmeng@tinylab.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: tests/avocado/riscv_opensbi.py does not work reliable
Autocrypt: addr=thuth@redhat.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


  Hi!

While running a lot of tests (i.e. with a very loaded machine), I noticed 
that tests/avocado/riscv_opensbi.py is very flaky when the host machine is 
slow. I can easily reproduce the problem when running a big compilation job 
on all CPUs in the background and then run the riscv_opensbi.py avocado 
test. One of test_riscv32_spike, test_riscv64_spike, test_riscv32_sifive_u 
or test_riscv64_sifive_u is failing most of the time (but not the virt 
machine tests).

Looking at the logs, it seems like the output sometimes stops somewhere at a 
random place before the boot process reaches the spot that the test is 
looking for. Looking at riscv_htif.c, there does not seem to be any flow 
control implemented here, so I guess at least the spike test is currently 
doomed to fail occasionally. Is there anything that can be done about this 
(e.g. is flow control somehow possible here or does the interface not allow 
this?)? Otherwise, I think it might be best to mark the spike and sifive_u 
tests with QEMU_TEST_FLAKY_TESTS here to make it clear that these tests are 
not reliable by default...?

  Thomas


