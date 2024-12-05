Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A826E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJNd-0005CH-78; Thu, 05 Dec 2024 16:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJJNc-0005C1-1P
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:27:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJJNZ-0005er-1A
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733434039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=10irXJn9nC8IGQ7evdcrM5rQKZ5ABrSgvX58EOKUzJ0=;
 b=SclqQ0Ce3t3Bk34FJVDu1SS7VGfqqcCUmWCA0Lg/ogf+E6d9Zy4gFCFhRxP0ULY8hEIcrc
 bw0Lx9gGBYRE85V9N0T64IJY8w/a54K0mM0fKsD8rbKM2EXAMnMTUrB/wisMRFcothjadT
 1NkeYSgZBf8/pUfZaRGmZ2wYjIA221g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-mAQE_i7KPr-9Y_qHa-Wlfg-1; Thu, 05 Dec 2024 16:27:16 -0500
X-MC-Unique: mAQE_i7KPr-9Y_qHa-Wlfg-1
X-Mimecast-MFC-AGG-ID: mAQE_i7KPr-9Y_qHa-Wlfg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4349e08ae91so11586785e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733434033; x=1734038833;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10irXJn9nC8IGQ7evdcrM5rQKZ5ABrSgvX58EOKUzJ0=;
 b=NUI7oE9YvEHgQNNjVoavUZ1EY2rZvUiL/C4D+wCNa7KRFmIXh88doItCrvDrV4uXdj
 f7CMlvW/IqMzAVcTgmWrYNOm6QvRMvw84P3XT+xwrUa+uMLsN1GxX46f4K2Gxa16KuiS
 9zWKkIRljF1blsSXnEP1CtqLKJxUNxuVNnpjgE2dD2nx/0/Vm33TvxFmrBXy09+q0zd3
 WY0znc1FMdovT2Z2l2MCLt4CZOoarOI37q6dVBDLHKWWAo/OeUMVw451PZqhtn+46Ngv
 gdqt77bw3rpXZxhbmRbutnVklEZOL/vDTI5N6B/6yV93vYcqTAwzTMjWhLA9R5MBND1T
 rPoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5ECSxJVjTraaEt6Xzsdq90ItdrsA1XW07vuo8LuQxStWkBQxLun3XonF/n86p32mqnIsFw87VpWIs@nongnu.org
X-Gm-Message-State: AOJu0YwMX0KljuRT1zLZONzACzipsQwzEzS3AhPy3KkEzqS2l5IF6lSN
 Jp00nxZ3GTVJGfpAo8QDKEH4qeNS7JMkFUrz8jjN+iVl+nlOHrj62VyhrYPJjnBQtIwLkIPG6iT
 5eSGgbyKNRRG+qBvxpecktoc62Qd4oJMrn94G2ivLvfN8gFp3UQxF
X-Gm-Gg: ASbGnct0V+m1HfblJGFVnAqfayOzr7K9ahqpHoINtulc2RwhAfrqL/BfQrmg7WZk1yb
 99N7vofYWPtX4LQSaqNYssqoEacXRrSSlLirtH/t1E0bTp3C0Vf2Q1EZTrFmBQ8nU9EP9CFAPYa
 KoarMFQ0ArOnKc3PXE3X0ZL2zCS+bASsmjdm6yExV0Ius2LyJC5+ZjzcPY9/imOVZIoHRbncPVR
 mxJlIHNPhlgZWKMojTyWk9CgfO7qPBlBMSW6/0ipYE9kZ5y3gMG64bYLdPit25jqhmnkZ8KyNXe
 KumTceDWMfb5
X-Received: by 2002:a05:600c:5107:b0:434:a1d3:a306 with SMTP id
 5b1f17b1804b1-434ddead1c5mr6817505e9.5.1733434033398; 
 Thu, 05 Dec 2024 13:27:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnLac9gZl1/U2jNJIH4/PoGobPm8Qs3x/CasNrtAa6duNOObyIIBUH77FV/z2ZQ0laFpzFtg==
X-Received: by 2002:a05:600c:5107:b0:434:a1d3:a306 with SMTP id
 5b1f17b1804b1-434ddead1c5mr6817365e9.5.1733434032953; 
 Thu, 05 Dec 2024 13:27:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52cbd5asm72220305e9.40.2024.12.05.13.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:27:11 -0800 (PST)
Message-ID: <7605f22f-79a9-4e15-b2ae-05d83a52242a@redhat.com>
Date: Thu, 5 Dec 2024 22:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v3_00/24=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/17/24 20:19, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This is an updated v3 patch series of the v2 series located here:
> https://lore.kernel.org/qemu-devel/cover.1724701542.git.maciej.szmigiero@oracle.com/
> 
> Changes from v2:
> * Reworked the non-AIO (generic) thread pool to use Glib's GThreadPool
> instead of making the current QEMU AIO thread pool generic.
> 
> * Added QEMU_VM_COMMAND MIG_CMD_SWITCHOVER_START sub-command to the
> migration bit stream protocol via migration compatibility flag.
> Used this new bit stream sub-command to achieve barrier between main
> migration channel device state data and multifd device state data instead
> of introducing save_live_complete_precopy_{begin,end} handlers for that as
> the previous patch set version did,
> 
> * Added a new migration core thread pool of optional load threads and used
> it to implement VFIO load thread instead of introducing load_finish handler
> as the previous patch set version did.
> 
> * Made VFIO device config state load operation happen from that device load
> thread instead of from (now gone) load_finish handler that did such load on
> the main migration thread.
> In the future this may allow pushing BQL deeper into the device config
> state load operation internals and so doing more of it in parallel.
> 
> * Switched multifd_send() to using a serializing mutex for thread safety
> instead of atomics as suggested by Peter since this seems to not cause
> any performance regression while being simpler.
> 
> * Added two patches improving SaveVMHandlers documentation: one documenting
> the BQL behavior of load SaveVMHandlers, another one explaining
> {load,save}_cleanup handlers semantics.
> 
> * Added Peter's proposed patch making MultiFDSendData a struct from
> https://lore.kernel.org/qemu-devel/ZuCickYhs3nf2ERC@x1n/
> Other two patches from that message bring no performance benefits so they
> were skipped (as discussed in that e-mail thread).
> 
> * Switched x-migration-multifd-transfer VFIO property to tri-state (On,
> Off, Auto), with Auto being now the default value.
> This means hat VFIO device state transfer via multifd channels is
> automatically attempted in configurations that otherwise support it.
> Note that in this patch set version (in contrast with the previous version)
> x-migration-multifd-transfer setting is meaningful both on source AND
> destination QEMU.
> 
> * Fixed a race condition with respect to the final multifd channel SYNC
> packet sent by the RAM transfer code.
> 
> * Made VFIO's bytes_transferred counter atomic since it is accessed from
> multiple threads (thanks Avihai for spotting it).
> 
> * Fixed an issue where VFIO device config sender QEMUFile wouldn't be
> closed in some error conditions, switched to QEMUFile g_autoptr() automatic
> memory management there to avoid such bugs in the future (also thanks
> to Avihai for spotting the issue).
> 
> * Many, MANY small changes, like renamed functions, added review tags,
> locks annotations, code formatting, split out changes into separate
> commits, etc.
> 
> * Redid benchmarks.
> 
> ========================================================================
> 
> Benchmark results:
> These are 25th percentile of downtime results from 70-100 back-and-forth
> live migrations with the same VM config (guest wasn't restarted during
> these migrations).
> 
> Previous benchmarks reported the lowest downtime results ("0th percentile")
> instead but these were subject to variation due to often being one of
> outliers.
> 
> The used setup for bechmarking was the same as the RFC version of patch set
> used.
> 
> 
> Results with 6 multifd channels:
>              4 VFs   2 VFs    1 VF
> Disabled: 1900 ms  859 ms  487 ms
> Enabled:  1095 ms  556 ms  366 ms
> 
> Results with 4 VFs but varied multifd channel count:
>               6 ch     8 ch    15 ch
> Enabled:  1095 ms  1104 ms  1125 ms
> 
> 
> Important note:
> 4 VF benchmarks were done with commit 5504a8126115
> ("KVM: Dynamic sized kvm memslots array") and its revert-dependencies
> reverted since this seems to improve performance in this VM config if the
> multifd transfer is enabled: the downtime performance with this commit
> present is 1141 ms enabled / 1730 ms disabled.
> 
> Smaller VF counts actually do seem to benefit from this commit, so it's
> likely that in the future adding some kind of a memslot pre-allocation
> bit stream message might make sense to avoid this downtime regression for
> 4 VF configs (and likely higher VF count too).
> 
> ========================================================================
> 
> This series is obviously targeting post QEMU 9.2 release by now
> (AFAIK called 10.0).
> 
> Will need to be changed to use hw_compat_10_0 once these become available.
> 
> ========================================================================
> 
> Maciej S. Szmigiero (23):
>    migration: Clarify that {load,save}_cleanup handlers can run without
>      setup
>    thread-pool: Remove thread_pool_submit() function
>    thread-pool: Rename AIO pool functions to *_aio() and data types to
>      *Aio
>    thread-pool: Implement generic (non-AIO) pool support
>    migration: Add MIG_CMD_SWITCHOVER_START and its load handler
>    migration: Add qemu_loadvm_load_state_buffer() and its handler
>    migration: Document the BQL behavior of load SaveVMHandlers
>    migration: Add thread pool of optional load threads
>    migration/multifd: Split packet into header and RAM data
>    migration/multifd: Device state transfer support - receive side
>    migration/multifd: Make multifd_send() thread safe
>    migration/multifd: Add an explicit MultiFDSendData destructor
>    migration/multifd: Device state transfer support - send side
>    migration/multifd: Add migration_has_device_state_support()
>    migration/multifd: Send final SYNC only after device state is complete
>    migration: Add save_live_complete_precopy_thread handler
>    vfio/migration: Don't run load cleanup if load setup didn't run
>    vfio/migration: Add x-migration-multifd-transfer VFIO property
>    vfio/migration: Add load_device_config_state_start trace event
>    vfio/migration: Convert bytes_transferred counter to atomic
>    vfio/migration: Multifd device state transfer support - receive side
>    migration/qemu-file: Define g_autoptr() cleanup function for QEMUFile
>    vfio/migration: Multifd device state transfer support - send side
> 
> Peter Xu (1):
>    migration/multifd: Make MultiFDSendData a struct
> 
>   hw/core/machine.c                  |   2 +
>   hw/vfio/migration.c                | 588 ++++++++++++++++++++++++++++-
>   hw/vfio/pci.c                      |  11 +
>   hw/vfio/trace-events               |  11 +-
>   include/block/aio.h                |   8 +-
>   include/block/thread-pool.h        |  20 +-
>   include/hw/vfio/vfio-common.h      |  21 ++
>   include/migration/client-options.h |   4 +
>   include/migration/misc.h           |  16 +
>   include/migration/register.h       |  67 +++-
>   include/qemu/typedefs.h            |   5 +
>   migration/colo.c                   |   3 +
>   migration/meson.build              |   1 +
>   migration/migration-hmp-cmds.c     |   2 +
>   migration/migration.c              |   3 +
>   migration/migration.h              |   2 +
>   migration/multifd-device-state.c   | 193 ++++++++++
>   migration/multifd-nocomp.c         |  45 ++-
>   migration/multifd.c                | 228 +++++++++--
>   migration/multifd.h                |  73 +++-
>   migration/options.c                |   9 +
>   migration/qemu-file.h              |   2 +
>   migration/ram.c                    |  10 +-
>   migration/savevm.c                 | 183 ++++++++-
>   migration/savevm.h                 |   4 +
>   migration/trace-events             |   1 +
>   scripts/analyze-migration.py       |  11 +
>   tests/unit/test-thread-pool.c      |   2 +-
>   util/async.c                       |   6 +-
>   util/thread-pool.c                 | 174 +++++++--
>   util/trace-events                  |   6 +-
>   31 files changed, 1586 insertions(+), 125 deletions(-)
>   create mode 100644 migration/multifd-device-state.c


I did a quick run of a VM with a mlx5 VF and a vGPU and I didn't see
any issue when migrating. I used 4 channels for multifd. The trace
events looked ok and useful. We will tune these with time. I wished
we had some way to dump the thread and channel usage on each side.

A build was provided to RHEL QE. This to get more results when under
stress and with larger device states. Don't expect feedback before
next year though !

Having a small cookbook to run the migration from QEMU and from
libvirt would be a plus.

Thanks,

C.


