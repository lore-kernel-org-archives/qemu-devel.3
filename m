Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9D7C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 04:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufADp-00011M-12; Fri, 25 Jul 2025 00:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufADO-0000fh-HY
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ufADH-0002FG-Kr
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753418357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bKTfUxiko+2ovI6qASIBHAMqFkFdLnLVklXMV/ksKkc=;
 b=Rg+vCFPfxiBbHyHlseteBN3uEp8vI5WatMqefRQY/jeC4o2uRtb0Xh1w3nKndBajjYdIqg
 G/xYajkwwASpRIx5G2UqYJ885Ovmb4pMn1We8BUFu9JMfXWObXMGSKVgnWRRMe2ntV6/gD
 j/aLqfkzqy5CGdKdYporFLSErBIyj2M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-yyeRXHKeNSOAiEYHKJfAeg-1; Fri, 25 Jul 2025 00:39:15 -0400
X-MC-Unique: yyeRXHKeNSOAiEYHKJfAeg-1
X-Mimecast-MFC-AGG-ID: yyeRXHKeNSOAiEYHKJfAeg_1753418355
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so9383585e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 21:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753418354; x=1754023154;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKTfUxiko+2ovI6qASIBHAMqFkFdLnLVklXMV/ksKkc=;
 b=EmCcbunQFqWLyfwd/91UaP5+A1489OWACXpggZcCsK031oS0bpt30yn89922ng4dhA
 uilA5qy160HKv8fQzvmOr6QMf2fQqCr/haPwzsEx1ZlVW2wCDQRqubIa2+3G1SJPOOMT
 rHEYOrDYzOPvTO0m+1cZNj3gx9D7x/EIW0JmGuQyKKGi/v4zS6yRgqgXUJBXuvt0Pac8
 9nRbfWJIUXQ2PdTbqA8ec0OvZTchBJiDvsmOTQVzTMADZ6rMgOesvFtHXwLnR5Gk0K14
 3H9N8oHsLg1M7sdWZHq4P0EggbBR573eNg5oJZG5asPdqpGMuUZPwV9WsdBc68pf7/qx
 0/xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGYgtWBdivES5QBpu7TAOv6HTL+ugFhfPvyGwhciaxjAGR7HPjDUIXP6WoniYaUFtrTKoWej2dnvqD@nongnu.org
X-Gm-Message-State: AOJu0Yx6yaQfRMMGt/2qQ2Oumd1w3lk6MlpCp9NcS6dAE1l0k4yck9WO
 2AE5MY2RDYzpqj9To+AXTSQyVu16shyoLWQSfTdD9cYzXEhgg+52zZuV+UJU942039Y2/AlIR6e
 VZ10QytipCXs9aiZXxw+MG7yFsJOJid8cv6+XXzPM+RjjHIqf1oSpaPiM
X-Gm-Gg: ASbGncuijRHipva3UsAwcWTMZx0fAtlrWuTvdw9Zir3Lif3iUfAf/LpwT93xYFOczgd
 cQ1Tf3pRc3KtHWvVK+pMVrPeJXlAHUgDt1CmQbKuj9cJXceG0zMpSClZeyxrrF27tM0PG71KuNl
 fcPC2MTZ26nZN3R0QSOk/Vy5hnp7MnpHZR/ZgX+UdDv+MVa224K0VWpeEtGGKhhb9KzcfyL+Fo8
 tgPIfJ+lZMTqIcQigDWsSdVJAUmgfsJSgZxz90FmE+LesHbFgtJhjuf5TqslKgfa4xeipc5KWSv
 U0abMbYgdIA5hEQw7x3gU+D7khEJjO3IX24byIxhyPUHoejlKbJehgK7goZ+qs66x8hW/cTzFsP
 LwUE=
X-Received: by 2002:a05:600c:4f0d:b0:456:2020:166a with SMTP id
 5b1f17b1804b1-458764394b2mr2150995e9.20.1753418354670; 
 Thu, 24 Jul 2025 21:39:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4koz+K76OP2DubS/o8uJr8zJ2TSJjvhiiAj7vw6BWpshWa4/slTr7hzxEfSc7B+PSPHf0tw==
X-Received: by 2002:a05:600c:4f0d:b0:456:2020:166a with SMTP id
 5b1f17b1804b1-458764394b2mr2150825e9.20.1753418354185; 
 Thu, 24 Jul 2025 21:39:14 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-089.pools.arcor-ip.net.
 [47.64.115.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705bcbfbsm41710955e9.16.2025.07.24.21.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 21:39:13 -0700 (PDT)
Message-ID: <b5d0c17b-cd99-494b-8919-665fd2519233@redhat.com>
Date: Fri, 25 Jul 2025 06:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tests/functional: add --list-tests CLI arg
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250718-functional_tests_args-v2-0-cde6e08bf98e@linaro.org>
 <20250718-functional_tests_args-v2-2-cde6e08bf98e@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
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
In-Reply-To: <20250718-functional_tests_args-v2-2-cde6e08bf98e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/07/2025 13.04, Manos Pitsidianakis wrote:
> Add CLI argument to list tests and exit.
> 
> Example output (current dir is build directory under root dir):
> 
>    $ export PYTHONPATH=../python:../tests/functional
>    $ export QEMU_TEST_QEMU_BINARY="$(pwd)/qemu-system-aarch64"
>    $ ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --list-tests
>    test_aarch64_virt_gicv2 (test_aarch64_virt.Aarch64VirtMachine.test_aarch64_virt_gicv2)
>    test_aarch64_virt_gicv3 (test_aarch64_virt.Aarch64VirtMachine.test_aarch64_virt_gicv3)
>    test_alpine_virt_tcg_gic_max (test_aarch64_virt.Aarch64VirtMachine.test_alpine_virt_tcg_gic_max)
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   tests/functional/qemu_test/testcase.py | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 9b00c63e6ca7a2a669fd456f1d1b51501ce4a726..bfee6638edf6f9853ead1e3809ae3c9152089406 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -50,6 +50,11 @@ def parse_args(test_name: str) -> argparse.Namespace:
>           "This is equivalent to setting QEMU_TEST_KEEP_SCRATCH=1 in the "
>           "environment.",
>       )
> +    parser.add_argument(
> +        "--list-tests",
> +        action="store_true",
> +        help="List all tests that would be executed and exit.",
> +    )
>       return parser.parse_args()
>   
>   
> @@ -280,10 +285,13 @@ def tearDown(self):
>   
>       def main():
>           path = os.path.basename(sys.argv[0])[:-3]
> -        # If argparse receives --help or an unknown argument, it will raise a
> -        # SystemExit which will get caught by the test runner. Parse the
> -        # arguments here too to handle that case.
> -        parse_args(path)
> +        args = parse_args(path)

As mentioned for the initial --debug patch already: How's about changing 
that "args" into a class variable instead and get rid of the parse_args() in 
the setUp() function?

  Thomas

> +        if args.list_tests:
> +            loader = unittest.TestLoader()
> +            for test_suite in loader.loadTestsFromName(path):
> +                for test in test_suite:
> +                    print(test)
> +            return
>   
>           cache = os.environ.get("QEMU_TEST_PRECACHE", None)
>           if cache is not None:
> 


