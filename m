Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35541CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 11:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3CVO-0002gD-5k; Mon, 29 Sep 2025 07:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3CVM-0002fy-EX
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 07:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3CVB-0000oO-B3
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 07:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759147022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=C+t+c9qIy47c8aoCdV90GMm/S1vYBqkuLA+eHlKTol0=;
 b=YJNgQl8ZRoRduq6AO9bh5lJ0xeybvepL0FB3AjIuOYaPGWw1McY7zg2meAa5cuLaMNRUAU
 weZvUF7m5fTcsVvIDuZLIsfn0XStegMI7NdVPimIXLD7/j2wDTN6HjnEEVSl3RxkVw8Zvm
 Wsg0O+/YWBxLQbjKerI+DG6bZ3oksbY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-Q5SpF3CVMLyim90AsV4AbQ-1; Mon, 29 Sep 2025 07:57:00 -0400
X-MC-Unique: Q5SpF3CVMLyim90AsV4AbQ-1
X-Mimecast-MFC-AGG-ID: Q5SpF3CVMLyim90AsV4AbQ_1759147020
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e35baddc1so28939795e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 04:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759147019; x=1759751819;
 h=content-transfer-encoding:autocrypt:subject:cc:to:content-language
 :from:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C+t+c9qIy47c8aoCdV90GMm/S1vYBqkuLA+eHlKTol0=;
 b=sh0qSWDox7FLUw5SFljFG+0ZejTUSRhTjjBx7JB9Yc/mB9mjr+OBvZ31PPdl6n8/AX
 RbzTR5iVvrKKR11aTeCMvMEMNrHP/ynVg+SF3wPl7IoZbG/92ZUARlMDbCJkzgk0libz
 P9XgCdmCSn72bmFLf4XWOFLEDIpea4S9eCNwThD0/sPRY3rJFUh1GErtQaRguzd8xXCS
 HMnrtPh71bH3M7ZQnw4wj+snFlSdLrWy/MNBGVpTY2BRorp8c4VKtcenycnv1KXqOmDL
 nM4WJTCRKH9jzdrlwh+U0TgqH7vcI0mMAjuXhPsABZojrmY+Tv5mgtJHqMnwB5uu8BKw
 8VjA==
X-Gm-Message-State: AOJu0YzDrItG57WxJUn1sn4FczxWj2zYVzh1N7hn01PWlpZ7gVzR/8xL
 cp1gtdPNM5I7CJm9NQ2VaSIX9tOnTkDuvcN559hcAyRj7a7i1INZ/ZM2tF2qGq2JnhF/HA6bPL7
 pLMkZs9Ey+vAWxr+T2hGXGB+/hQjxr0Z4qq4t6Nhi6ilWTNRoF0fuPYb0kXU6bj8C
X-Gm-Gg: ASbGnctIxvJHchgQSQGCLwQyZv6u9ZncazB3sERPZz7UCrfv0rkU+6Vl/w+QcQwGl1I
 PJQxOn+2W7InYurDU8s1zpB/OJoOaI/wRaMsjtz2LkFj3HOI842WF+8rsTYEhMCaWDt22koB/ak
 2MvWZ+rQn5y13iMuAEwb4n5zdcnBgeAKSeH8gufFlBMvKox047OhlgYwVLbnMyJ+X6G5strRXvK
 qp75UZkbex5OsQA8c7xtn5LDIpcDQAPMj/xA2oruKCfPegHXt6mb9WZXQV8gL8zwS74MkPhpI58
 WH6l0JEVC6jJMQqMFTKcwJRUaPWnppzt8Kd+fyuIlMGl8//dypN4HZCGxNlnx7TmSpSBNSJ+rm/
 ckF7wkA==
X-Received: by 2002:a05:600c:8b16:b0:468:7f92:5a80 with SMTP id
 5b1f17b1804b1-46e329fbd2bmr122580795e9.27.1759147019548; 
 Mon, 29 Sep 2025 04:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvSIwurcb1ZUCrdgpbavpn6woKwuRaulLiix/uOp/bosyAZB7O28ytq6Xq+Qm1yWCpgJ0N4g==
X-Received: by 2002:a05:600c:8b16:b0:468:7f92:5a80 with SMTP id
 5b1f17b1804b1-46e329fbd2bmr122580555e9.27.1759147018988; 
 Mon, 29 Sep 2025 04:56:58 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc72b0aeesm18429280f8f.49.2025.09.29.04.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 04:56:58 -0700 (PDT)
Message-ID: <a637a6be-ac18-4cf2-ae31-392de0676ab3@redhat.com>
Date: Mon, 29 Sep 2025 13:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
To: Qemu-block <qemu-block@nongnu.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Two iotests failing with -qcow
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


  Hi,

FYI, two iotests are currently failing when running "./check -qcow" :

301                             fail       [13:27:50] [13:27:52]   1.8s 
            output mismatch (see 
/tmp/qemu-qcow1/tests/qemu-iotests/scratch/qcow-file-301/301.out.bad)
--- /tmp/qemu/tests/qemu-iotests/301.out
+++ /tmp/qemu-qcow1/tests/qemu-iotests/scratch/qcow-file-301/301.out.bad
@@ -3,6 +3,7 @@
  == qcow backed by qcow ==
  Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=33554432
  qemu-img: TEST_DIR/t.IMGFMT: Backing file specified without backing format
+Detected format of IMGFMT.
  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 
backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
  image: TEST_DIR/t.IMGFMT
  file format: IMGFMT
@@ -31,6 +32,7 @@

  == qcow backed by raw ==
  qemu-img: TEST_DIR/t.IMGFMT: Backing file specified without backing format
+Detected format of raw.
  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 
backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
  image: TEST_DIR/t.IMGFMT
  file format: IMGFMT

and:

graph-changes-while-io          fail       [13:28:05] [13:28:42]   37.4s 
            failed, exit status 1
--- /tmp/qemu/tests/qemu-iotests/tests/graph-changes-while-io.out
+++ 
/tmp/qemu-qcow1/tests/qemu-iotests/scratch/qcow-file-graph-changes-while-io/graph-changes-while-io.out.bad
@@ -1,5 +1,107 @@
-...
+..qemu-storage-daemon: Could not update backing file link: Operation not 
supported
+EE
+======================================================================
+ERROR: test_remove_lower_snapshot_while_io 
(__main__.TestGraphChangesWhileIO.test_remove_lower_snapshot_while_io)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/usr/lib64/python3.13/asyncio/tasks.py", line 507, in wait_for
+    return await fut
+           ^^^^^^^^^
+  File "/tmp/qemu/python/qemu/qmp/events.py", line 591, in get
+    return await self._queue.get()
+           ^^^^^^^^^^^^^^^^^^^^^^^
+  File "/usr/lib64/python3.13/asyncio/queues.py", line 186, in get
+    await getter
+asyncio.exceptions.CancelledError
+
+The above exception was the direct cause of the following exception:
+
+Traceback (most recent call last):
+  File "/tmp/qemu/tests/qemu-iotests/tests/graph-changes-while-io", line 
183, in test_remove_lower_snapshot_while_io
+    self._wait_for_blockjob('concluded')
+    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^
+  File "/tmp/qemu/tests/qemu-iotests/tests/graph-changes-while-io", line 
66, in _wait_for_blockjob
+    for event in self.qsd.get_qmp().get_events(wait=10.0):
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
+  File "/tmp/qemu/python/qemu/qmp/legacy.py", line 279, in get_events
+    event = self.pull_event(wait)
+  File "/tmp/qemu/python/qemu/qmp/legacy.py", line 254, in pull_event
+    self._sync(
+    ~~~~~~~~~~^
+        self._qmp.events.get(),
+        ^^^^^^^^^^^^^^^^^^^^^^^
+        timeout
+        ^^^^^^^
+    )
+    ^
+  File "/tmp/qemu/python/qemu/qmp/legacy.py", line 106, in _sync
+    return self._aloop.run_until_complete(
+           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
+        asyncio.wait_for(future, timeout=timeout)
+        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+    )
+    ^
+  File "/usr/lib64/python3.13/asyncio/base_events.py", line 725, in 
run_until_complete
+    return future.result()
+           ~~~~~~~~~~~~~^^
+  File "/usr/lib64/python3.13/asyncio/tasks.py", line 506, in wait_for
+    async with timeouts.timeout(timeout):
+               ~~~~~~~~~~~~~~~~^^^^^^^^^
+  File "/usr/lib64/python3.13/asyncio/timeouts.py", line 116, in __aexit__
+    raise TimeoutError from exc_val
+TimeoutError
+
+======================================================================
+ERROR: test_remove_lower_snapshot_while_io 
(__main__.TestGraphChangesWhileIO.test_remove_lower_snapshot_while_io)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/tmp/qemu/tests/qemu-iotests/tests/graph-changes-while-io", line 
60, in tearDown
+    self.qsd.stop()
+    ~~~~~~~~~~~~~^^
+  File "/tmp/qemu/tests/qemu-iotests/iotests.py", line 480, in stop
+    self._qmp.close()
+    ~~~~~~~~~~~~~~~^^
+  File "/tmp/qemu/python/qemu/qmp/legacy.py", line 288, in close
+    self._sync(
+    ~~~~~~~~~~^
+        self._qmp.disconnect()
+        ^^^^^^^^^^^^^^^^^^^^^^
+    )
+    ^
+  File "/tmp/qemu/python/qemu/qmp/legacy.py", line 106, in _sync
+    return self._aloop.run_until_complete(
+           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
+        asyncio.wait_for(future, timeout=timeout)
+        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+    )
+    ^
+  File "/usr/lib64/python3.13/asyncio/base_events.py", line 725, in 
run_until_complete
+    return future.result()
+           ~~~~~~~~~~~~~^^
+  File "/usr/lib64/python3.13/asyncio/tasks.py", line 507, in wait_for
+    return await fut
+           ^^^^^^^^^
+  File "/tmp/qemu/python/qemu/qmp/protocol.py", line 443, in disconnect
+    await self._wait_disconnect()
+  File "/tmp/qemu/python/qemu/qmp/protocol.py", line 763, in _wait_disconnect
+    await all_defined_tasks  # Raise Exceptions from the bottom half.
+    ^^^^^^^^^^^^^^^^^^^^^^^
+  File "/tmp/qemu/python/qemu/qmp/protocol.py", line 914, in _bh_loop_forever
+    await async_fn()
+  File "/tmp/qemu/python/qemu/qmp/protocol.py", line 952, in _bh_recv_message
+    msg = await self._recv()
+          ^^^^^^^^^^^^^^^^^^
+  File "/tmp/qemu/python/qemu/qmp/protocol.py", line 1053, in _recv
+    message = await self._do_recv()
+              ^^^^^^^^^^^^^^^^^^^^^
+  File "/tmp/qemu/python/qemu/qmp/qmp_client.py", line 459, in _do_recv
+    msg_bytes = await self._readline()
+                ^^^^^^^^^^^^^^^^^^^^^^
+  File "/tmp/qemu/python/qemu/qmp/protocol.py", line 1021, in _readline
+    raise EOFError
+EOFError
+
  ----------------------------------------------------------------------
  Ran 3 tests

-OK
+FAILED (errors=2)

Should these tests maybe just be marked as non-working with qcow1 ?

  Thomas


