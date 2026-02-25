Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A249FD45E4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 19:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvKix-0007nJ-1y; Wed, 25 Feb 2026 14:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvKin-0007mr-Aw
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:39:00 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvKik-0001qv-Hu
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:38:55 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-354c67da885so6080789a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 11:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772048333; x=1772653133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kOFGeA0FqE7Y8Al53D3nhfM0GksmdGXgOPfl105bU9o=;
 b=lIWtrwmj5gv0TILkplOR0mzKNN7rdP/x2gP3boSQSdt9hBqlGgFPWeGWpf9Nd4/QPY
 2WxfKJL6fPkfC0GOo5G6MWv86kNbpSWgr9CkJqzuqFeJgDJVTTfHWTtj+OO8BhDvTYuk
 +HDd532KG2/yp4Mup29izw0PWxCPW59wUrRGMzIi2j/1LYE71+q9QkhXqj3BJzMpAVb9
 Zb7uQuMjZ2H6mVfZLp+d1/sH8IAdLWW0bM++l0KNe1wkbVs6moKzJlyhr4ohzMwy039s
 MVgmilDc5LifnEwtKnGozvjRQJKSF0lF4xRkqiQ7ZkTETp5OD7kyIA4TRAkElziwB6+P
 9U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772048333; x=1772653133;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kOFGeA0FqE7Y8Al53D3nhfM0GksmdGXgOPfl105bU9o=;
 b=kJQM/eBpJz8z9ICDGiyAzolIIMLtnpyNMV4IysJxj+unMp8Q1JB04oOtcwNLNIh9B2
 M7I3LIu4uZg3uTqcN18XXWZe2Tgggk4y+K0Z++qjk2uqNUPI7jFzVw+zx6A7kLyFAtHN
 LwZXfDiI3EA5Zuf9DLaPmumXWxM6Su2Gg/t8kJrDKFH0wvWRxSGCPP87p0Mz1+gb1tkB
 jpnfSplmor8oNNSqeBKt4LM/l5efhnxC9Bqym5YcXo4Qd8M0E+gKnz+2eBHRhQFC7hv5
 tCXyKVfVULJ6L6TTtSV9a28cv9clmwQlg280KC3wD38FPpYrAe74LM3KeIfZKwMeFOEa
 7ycQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2IvyqXSUMBUN3MBsEjiVpehnMMIRJGQhxZni+Ia92hcFpyY4x2Mr9dCyWR4B5lgVATZ3FwixQNXxd@nongnu.org
X-Gm-Message-State: AOJu0Yz8v+DibHzgi25f06GLDeNTj01TbvKx39JSifn2JNLlhPYh/4g/
 4ATFo4u02nMCQHCP15Gncwqil8D7/OtENdF98+5/KC1zM2lbZFWFXMsUQLb6/+Kpl+pyysDgt0Z
 TIEjL
X-Gm-Gg: ATEYQzxLJk+jgE4g1CygyIZXAa4EQVInMPdpY9nlQ29BkJBWvoA138Rq3jtpx1yWrfQ
 k9gKiyYSzEN/F3nuoNFu3Nv0D1dLwmtDVNXIVNR0/UlC8515QKJUXoF1TlLBCNCfsypPCb6Xa3U
 yyEPrTVh0aAZImr61BF2mff3DEGpivjqFx+eYzfpHJWuPi8be6JabowFfCMDPmo8SdDXDJYjxoU
 0uzENLMEuvYSyvjtlwkkPlRqJc7YFxP9T60O633zdCYgTdZfTOTQUqNjPZVHIktCBs9Ys6kvBcb
 y5vJDWHQTchaQmhPD/pRlqmsF0QNjiAsAJ3RjhDDnGG/QEYCumC0VYlheoN/HObwHUiv/ZxQR+h
 F3jncHoa4IJTiJOJfo1N8XjZOI8RVBl5817eB67thTbrYLPIotE7raodFPkWb8Mw4MiO+C2Ij5V
 JqQ0OyBkm1dfkVxHQ7WRVD8Y3678kGDzCEod6aNqtfaU9k/c8Kta9JanQCH+zit4wGPjNI
X-Received: by 2002:a17:90b:33c3:b0:340:ca7d:936a with SMTP id
 98e67ed59e1d1-35928b880demr1366464a91.18.1772048332611; 
 Wed, 25 Feb 2026 11:38:52 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359037c8384sm3585945a91.17.2026.02.25.11.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 11:38:52 -0800 (PST)
Message-ID: <c216fec4-0fd1-4f02-8b85-bd2b24bfb954@linaro.org>
Date: Wed, 25 Feb 2026 11:38:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] tests/qtest: Add qtest-attrs-test to verify memory
 access with attr
Content-Language: en-US
To: Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>
References: <20260222082529.491384-1-tangtao1634@phytium.com.cn>
 <20260222082529.491384-3-tangtao1634@phytium.com.cn>
 <aZ8Jtl8jxBqDq8Rz@ZEVORN-PC.localdomain>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <aZ8Jtl8jxBqDq8Rz@ZEVORN-PC.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_SUBJ_META=2.499 autolearn=no autolearn_force=no
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

On 2/25/26 6:48 AM, Chao Liu wrote:
>> +static void test_arm_memwrite_memread_secure(void)
>> +{
>> +    QTestState *qts;
>> +    uint8_t wbuf[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
>> +                         0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF };
>> +    uint8_t rbuf[16];
>> +
>> +    if (!qtest_has_machine("virt")) {
>> +        g_test_skip("virt machine not available");
>> +        return;
>> +    }
>> +
>> +    qts = qtest_init(ARM_MACHINE_ARGS);
>> +
> Every single test function calls qtest_init/qtest_quit, which
> means starting and stopping a full QEMU instance for each test.
> For the ARM tests alone that's 14 QEMU startups. This will be
> very slow. Consider using a test fixture (g_test_add) to share
> the QTestState across tests of the same architecture.
> 

Tao initially implemented something like this. However, it means that 
you now need to cleanup/reset SMMU state between state, which is fragile 
and requires even more code. Thus, at the time, I suggested to simply 
spawn a new machine for every test.

I would be prudent to call that slow and optimize before effectively 
checking how long it gains. If we gain only 5 seconds by doing this, 
it's not really worth all the complication. If that's 2 minutes, well, 
it might be a good reason to group tests per categories.

For now, the full test takes 3 seconds on an optimized or debug build on 
my machine. Thus, I definitely don't think it requires any more 
complexity than this. The day it'll reach 30 seconds in debug build, 
maybe we can reconsider this.

Regards,
Pierrick


