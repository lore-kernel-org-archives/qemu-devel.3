Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356ADC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 16:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp9aS-0007jR-HP; Tue, 26 Mar 2024 12:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rp9aQ-0007gA-VZ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rp9aP-0002YE-BY
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711470220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tSYb1rb0Fr+tsk/0X0Sf4ja0cPbnw84LGpPcI1eurfg=;
 b=AvPkTlONxmkitPBT8cIaG5VFJxJZSxF2MCEee49mNYm2Dxd1fTBTUhc2NSin94qlrAfbfo
 Lmcsm8LDBAiq9Bu0LUdqOjpakF3f4UfIMKTXy3+MTaCMynvJ+07dsiSr9tQhDV3ej927gJ
 o08hOvNHJGS8Dypxm3xoLaZ2eU3vVfo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-QM6-LdbnO5KwJRNmKTqTdw-1; Tue, 26 Mar 2024 12:23:39 -0400
X-MC-Unique: QM6-LdbnO5KwJRNmKTqTdw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78319f64126so742191585a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 09:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711470218; x=1712075018;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSYb1rb0Fr+tsk/0X0Sf4ja0cPbnw84LGpPcI1eurfg=;
 b=wOiGDqIzhx0RGG80I7b4Hzync927RAqDtYJwQEf9FTtyIefjEfCTJ8KcmYFOLoMPHA
 yopKkrJIvABMNbl/s3XihUlWmq4+563uhkvRckHwQRkcMTwuHJbOOofspheC5So58/x8
 RUa1WRkWo9z+2ySoNmVgTjxFqkVu5azzMR8qQRbyY5g37+W7gSxqm0NvOLPbs+RH7LbI
 wTNXdXNI1aFDpVjJz+QTx5GUjfvx7+0qxNrIS9Sn71rEPLVMM9cGsCJGF5iTd+xHW2KL
 Pv9KDsMtOFX1qTRwk3Fwj0FW74XrJ5twDEqPfesIRav8XmChxYZspgrvkOdbiEag5R9m
 5yjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnRN5B5vpJMmvBjvttC7aVaUH7JKTMf9btSYqfcoTnOMWHca30ERVCAAw/AIoalpapxoooMap0Dsr/UIBLZLmGxWnqUDQ=
X-Gm-Message-State: AOJu0YxhfkNb4iYF0MalbVFFDfTYB/NJbQlmnICfDNV6+WQCrSXBMv3/
 6PnA77bBa8A1tx/SaH8K5IgmvbHzS9bR8wlTjiXpHDaR20hLC2sVZSZqQ+abBWil5pNEEtroVkw
 NJylnAUJ4LW7w0GGfNsZSIq5Rmbd3gBEkgOSK2/MSR0DPcOaPrd8V
X-Received: by 2002:a05:620a:5e52:b0:78a:5ed6:e388 with SMTP id
 ya18-20020a05620a5e5200b0078a5ed6e388mr1747018qkn.39.1711470218364; 
 Tue, 26 Mar 2024 09:23:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5zPc+PG1bukqw77mJjtyiQ5kRP6Am8urQMK7KcrM8Vk97Wlo9d6olmtZ/5jwpFyHGitx7WQ==
X-Received: by 2002:a05:620a:5e52:b0:78a:5ed6:e388 with SMTP id
 ya18-20020a05620a5e5200b0078a5ed6e388mr1746994qkn.39.1711470218011; 
 Tue, 26 Mar 2024 09:23:38 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-37.web.vodafone.de.
 [109.43.177.37]) by smtp.gmail.com with ESMTPSA id
 ye24-20020a05620a3b9800b00789fc794dbesm3128874qkn.45.2024.03.26.09.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 09:23:37 -0700 (PDT)
Message-ID: <2a016183-f832-4ecb-b7d4-ed1b5c22e3b2@redhat.com>
Date: Tue, 26 Mar 2024 17:23:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 0/3] qtest/virtio-9p-test.c: fix slow tests
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, groug@kaod.org, peter.maydell@linaro.org,
 qemu_oss@crudebyte.com
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20240326132606.686025-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26/03/2024 14.26, Daniel Henrique Barboza wrote:
> Hi,
> 
> Thomas reported in [1] a problem that happened with the RISC-V machine
> where some tests from virtio-9p-test.c were failing with '-m slow', i.e.
> enabling slow tests.
> 
> In the end it wasn't a RISC-V specific problem. It just so happens that
> the recently added riscv machine nodes runs the tests from
> virtio-9p-test two times for each qos-test run: one with the
> virtio-9p-device device and another with the virtio-9p-pci. The temp dir
> for these tests is being created at the start of qos-test and removed
> only at the end of qos-test, and the tests are leaving dirs and files
> behind. virtio-9-device tests run first, creates stuff in the temp dir,
> then when virtio-9p-pci tests runs again it'll fail because the previous
> run left created dirs and files in the same temp dir. Here's a run that
> exemplifies the problem:
> 
> $ MALLOC_PERTURB_=21 V=2 QTEST_QEMU_BINARY=./qemu-system-riscv64 ./tests/qtest/qos-test -m slow
> (...)
> # starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-621710.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-621710.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M virt,aclint=on,aia=aplic-imsic -fsdev local,id=fsdev0,path='/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2',security_model=mapped-xattr -device virtio-9p-device,fsdev=fsdev0,mount_tag=qtest -accel qtest
> ( goes ok ...)
> # starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-621710.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-621710.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M virt,aclint=on,aia=aplic-imsic -fsdev local,id=fsdev0,path='/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2',security_model=mapped-xattr -device virtio-9p-pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest -accel qtest
> ok 168 /riscv64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/config
> Received response 7 (RLERROR) instead of 73 (RMKDIR)
> Rlerror has errno 17 (File exists)
> **
> ERROR:../tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: assertion failed (hdr.id == id): (7 == 73)
> 
> As we can see we're running both 'virtio-9p-device' tests and 'virtio-9p-pci'
> tests using the same '/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2'
> temp dir.
> 
> The quick fix I came up with was to make each test clean themselves up
> after each run. The tests were also consolidated, i.e. fewer tests with the
> same coverage, because the 'unlikat' tests were doing the same thing the
> 'create' tests were doing but removing stuff after. Might as well keep just
> the 'unlikat' tests.
> 
> I also went ahead and reverted 558f5c42efd ("tests/9pfs: Mark "local"
> tests as "slow"") after realizing that the problem I was fixing is also
> the same problem that this patch was trying to working around with the
> skip [2]. I validated this change in this Gitlab pipeline:
> 
> https://gitlab.com/danielhb/qemu/-/pipelines/1227953967
> 
> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2020-11/msg05510.html
> 
> Daniel Henrique Barboza (3):
>    qtest/virtio-9p-test.c: consolidate create dir, file and symlink tests
>    qtest/virtio-9p-test.c: consolidate hardlink tests

Thanks, these fix the "make check SPEED=slow" problems for me!

Tested-by: Thomas Huth <thuth@redhat.com>



