Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4509CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMrj-00064y-8R; Wed, 07 Oct 2026 04:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEHDs-0002WJ-Tp
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:18:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEHDf-0006Sv-0k
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:17:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696Henb31163226
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 20:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V5rfjjOY8C0wwlhj1WJ6WmyLKsFMQ4dDON+6Wzw7hTY=; b=m1yXP0Ej15XMr4BO
 6QlvNNrkotz2crGqwrl+psf2AoyS7vC74Gx/tHCyq858s3IJY2je7oH+F4E3P1VC
 KHo0f8edeePFqYpf2L1QnMavsmfxDZZYeDVjEQZeXrWhy+QSGDTu9Fze+3ERfyI9
 I11gFjFSCMT0pd23nN73gnZPaJQkq31+G6oVRhzArs87h0wSYMk8gcr+PRJA4kwm
 8rbx+CmfZK7Zn46+gKvij9zvB0wn5OTr+uPCHwDzKvgfWx9/Q6bzAQxAGEUhDXOE
 1k1FlLLEWnr8g6mO4l/M7/3rXwbjJbG1g59u+6c6FpXCQU1S0IXUUpB5i4Njo4R+
 +66BuA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xduam4j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:18:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so3103429eec.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 13:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791317935; x=1791922735; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V5rfjjOY8C0wwlhj1WJ6WmyLKsFMQ4dDON+6Wzw7hTY=;
 b=Esz9lCZ04PYhr3c0xrHTg8dd9CLDijHEhWkbCqlMrQd7flL0lngwLafA49rPRr8TLk
 q/wPfFh/GsEbP1rqQXjGxSLWbm7dztVQvSfBHTjxQ7Ai+8LzASkIGyltK1DdNjOv3FsS
 B282jcCGEX+xx9geQyWb7VITOia3a/4lymwEx0P05w7Hy/52dqPNv1ybTTYCYyYpISGf
 /AQOnoshqwwZyr/PGg+9M08X8jH+t+HxWbpYNrxyzniDpeHAV/6pGcn2wvFQfmw8WRyb
 Mj/I3nO0ADGFUV9CpHy9BElPHw9gtb/miZUWcmCpVujd6wYaRlTKQdYELH6aw/HTyYGa
 HXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791317935; x=1791922735;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V5rfjjOY8C0wwlhj1WJ6WmyLKsFMQ4dDON+6Wzw7hTY=;
 b=lO6Ia6+q0xKOQTDPaDR/IdoKQFeVpteJV3E4NuACkmCqSbag7cMhApCZaP12DYyk/R
 ULq+pT7FIYzr0SoPmWoerrroEIt35cBSIwiuUDkB4jMtfO2dtN8on8Y0dIszPI9migwD
 MOVB55BJIcC5TBQVfuunS/Xfb+IcXGq1h6ID/LFq6PveT2uNzX63U2b+CkjN5Mw3cwm7
 HckxvhBF6CGLTqmHt4iu4d14JuwoHPRdkYzss5rl7aFe4wQAGZad9PADpoc7FDnY/l2g
 FJcF7+TnMvw8I9dfeGEZB2igXn4D69Q/65Nfqgm0pKN0yFvVXKXgQalsR/ZEOeEqe++C
 MjUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIHl7H4GWzG65mluX4K6e1/eKpngOlRFZc7mTrp0uRI6kBw+tlZbln1hMoc2Wru0OS161+Tty4eA+6@nongnu.org
X-Gm-Message-State: AFq9FYLStyWtxMq2ckHa6sDsFyLJ8B1fED0xyNbUaDlvkBKqXeqbDPtm
 7xHPH9RlljFJXLw3QwQ9JKJhLE6/NgzrUgVHozNiPjlUHXsk8uImQZCSiZXYeP5GwUSsuB6HFqp
 1aBT1qOY+ixf6E9bHqUdBGVd8UYgffPiHYa3kH+cJMGD5eenUgwtVGeIR9A==
X-Gm-Gg: AYBFou1vyDirMvlNh6401NUrtGpx3LEu6GlAxCciwGW+u4eJYQNfNu048SRuJsvAxVV
 QWMIM379SO+zqcRI8FuH3dBBKY/sGQeyBoMVo3fyPhVF7KnlsgVMEPDy3BKblMpJ0fIPc7AcGoX
 cy6WyjccgqtbpHz1n93NOYYxvACPWJSmRdofEebJwT4WxanHenVbIOv1LfyG40UqrD8uARJLuTw
 NtrGq92qk+8hzvicUFvdnYOl+NBewfvcnS0lyCOV6Nu29nDirw2Waif0VvkzA9x/9MXZ6yikfH6
 r+wuUKxT2WMBnRH88svbm87DMstXFS6Z2MHrqOVrHw/tcHV8KxZ7wgqA1c/NXYiw2EF2ShOPNre
 yTL6qV+TgG1izcPOez1y91i3Vf9i5B6hze1lS+Z0/58JdLrLazoH1Cj6IBU6S5Geq9sxT5A==
X-Received: by 2002:a05:693c:26cb:b0:351:4b50:4063 with SMTP id
 5a478bee46e88-3514e383ee3mr2495975eec.37.1791317934600; 
 Tue, 06 Oct 2026 13:18:54 -0700 (PDT)
X-Received: by 2002:a05:693c:26cb:b0:351:4b50:4063 with SMTP id
 5a478bee46e88-3514e383ee3mr2495944eec.37.1791317933931; 
 Tue, 06 Oct 2026 13:18:53 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515abb67e5sm857231eec.4.2026.10.06.13.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 13:18:53 -0700 (PDT)
Message-ID: <1a812cd8-45ac-4c31-846c-f4537d3e5871@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 13:18:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: luoyonggang@gmail.com
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Philippe Mathieu-Daude
 <philmd@mailo.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
 <asT-GoQ6xH4-dLET@redhat.com>
 <2dc73982-a162-415e-92a3-48bd0cb018ce@oss.qualcomm.com>
 <c51c23de-fe63-44bb-b8da-611e4ac27cb5@oss.qualcomm.com>
 <CAE2XoE9b48w5xJKdLBnSVuwFngx-+cMpf6rEgDztzZEt=UkqMQ@mail.gmail.com>
 <edea61bf-e80b-4478-af6e-7cf4ddeac59a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <edea61bf-e80b-4478-af6e-7cf4ddeac59a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA4MCBTYWx0ZWRfX+jZDeqVpYMp+
 WHgqr1+PahK8P7iu+m5RQUb61aO4ySlfvNiNTzgRcJ883EcLKL52DSYw+QPBJBsWZ6l9iwOUwfI
 Sw2omPBJRV/oUoN3So0DKsdPbke+uWQ=
X-Authority-Analysis: v=2.4 cv=NshE4MdJ c=1 sm=1 tr=0 ts=6ac557af cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=mDV3o1hIAAAA:8 a=btQIGe9K-Zo8chT4vwMA:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: tY49rhgItl19BVnh0t9vlZoJnsZOEQuS
X-Proofpoint-ORIG-GUID: tY49rhgItl19BVnh0t9vlZoJnsZOEQuS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA4MCBTYWx0ZWRfX5fKYTMzl11Wz
 lGMk4B62zRz4C1E68ILEaIpMFFR7LWGPe1Qzg/K3zvR8LhtwU03tb2dPAPmtQteugHDPA2oPHbt
 inYfxQocnOwhRdXAfpspGD83aN49oOTwP7QCr07bFhIFCMUzTF5PTpJZtUHU5zH3OMy4UiPHUbV
 yl7qjzr2MdSj2slX30iQdA5OB6eLNXWotvmUAAtW5xpZaNXRECc1oTejihd45AXNU5MWpoVhYXU
 NXK1aer6KGDwvs3BY3vEjkDqGRMuZoDZwECgmWy+cvOpNntXUkTPT3rNGHM8UM9AwV4DSQag0nZ
 52Ap94DXaooLja9LXK+xDKWYEUDOsOF3j1xswJ/LuolO97/PTbvVpipK3VAMcy5I+kxYS2DPlrR
 HPTz/cUhtgT9cOK6tVMv2VjNAaeEXJUwawUZ7RJKyFwMKl4jXJoI94Ugiwtyy6joRod9672OEYG
 WNd7fqnFVBCLVcvB/Ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060080
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/6/2026 12:32 PM, Pierrick Bouvier wrote:
> On 10/6/2026 11:46 AM, Yonggang Luo wrote:
>> where I do not see it
>>
> 
> I wonder if list is down, I don't see any new thread on it...
>

It seems to be down for now.

   ----- Transcript of session follows -----
<qemu-devel@nongnu.org>... Deferred: eggs.gnu.org.: No route to host
Warning: message still undelivered after 4 hours
Will keep trying until message is 5 days old

I'll wait and resend the series when it's back.

>>
>>          此致
>> 礼
>> 罗勇刚
>> Yours
>>     sincerely,
>> Yonggang Luo
>>
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com
>> <mailto:pierrick.bouvier@oss.qualcomm.com>> 于 2026年10月7日周三 02:30写道：
>>
>>     On 10/6/2026 10:31 AM, Pierrick Bouvier wrote:
>>     > On 10/6/2026 6:56 AM, Daniel P. Berrangé wrote:
>>     >> On Mon, Oct 05, 2026 at 11:52:48AM -0700, Pierrick Bouvier wrote:
>>     >>> On 10/5/2026 11:45 AM, Yonggang Luo wrote:
>>     >>>> On Tue, Oct 6, 2026 at 2:06 AM Pierrick Bouvier
>>     >>>> <pierrick.bouvier@oss.qualcomm.com
>>     <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>     >>>>>
>>     >>>>> On 10/5/2026 10:04 AM, Yonggang Luo wrote:
>>     >>>>>> On Tue, Oct 6, 2026 at 12:25 AM Pierrick Bouvier
>>     >>>>>> <pierrick.bouvier@oss.qualcomm.com
>>     <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>     >>>>>>>>>
>>     >>>>>>>>> Ok, but I'm not sure it answers the why.
>>     >>>>>>>>> Could you explain the benefits?
>>     >>>>>>>>
>>     >>>>>>>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for
>>     user-binary because
>>     >>>>>>>> The following original code would return -1 for some user-
>>     binary
>>     >>>>>>>> +    SysEmuTarget arch = target_info()->target_arch;
>>     >>>>>>>> +
>>     >>>>>>>> +    if (arch == SYS_EMU_TARGET__MAX) {
>>     >>>>>>>> +        arch = qapi_enum_parse(&SysEmuTarget_lookup,
>>     target_name(), -1,
>>     >>>>>>>> +                               &error_abort);
>>     >>>>>>>> +    }
>>     >>>>>>>> +    return arch;
>>     >>>>>>>> So basically assigning any value for the user binary is valid.
>>     >>>>>>>> SYS_EMU_TARGET__MAX is more explicit as it's related to
>>     type SysEmuTarget.
>>     >>>>>>>> -1 is another option but easy to confuse.
>>     >>>>>>>>
>>     >>>>>>>>
>>     >>>>>>>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
>>     >>>>>>>> "target-info: Statically initialize target_arch"
>>     >>>>>>>> doing that, I am not sure.
>>     >>>>>>>>
>>     >>>>>>>
>>     >>>>>>> I guess there is a (good or bad) reason for which sub
>>     variants of
>>     >>>>>>> targets are not reflected in SYS_EMU_TARGET enum. We should
>>     double check
>>     >>>>>>> that before doing any change, as it might have other
>>     consequences.
>>     >>>>>>
>>     >>>>>>
>>     >>>>>> You’re right to ask, and I need to correct my earlier suggestion:
>>     >>>>>> leaving user-mode target_arch
>>     >>>>>>  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used
>>     by ARM
>>     >>>>>> code shared with user-mode builds,
>>     >>>>>> including cpu-max-v8.c, where its result indexes a two-entry
>>     array.
>>     >>>>>> For aarch64-linux-user, the sentinel could therefore cause an
>>     >>>>>> out-of-bounds access during type registration.
>>     >>>>>>
>>     >>>>>> I checked the distinction: softmmu needs the full system-target
>>     >>>>>> identity, including variants such as mipsel;
>>     >>>>>> user-mode variants such as aarch64_be use their base TARGET_ARCH
>>     >>>>>> (aarch64) for this enum. I’ll keep the full TARGET_SYS_EMU
>>     >>>>>>  value for softmmu and use TARGET_ARCH for user-mode builds,
>>     rather
>>     >>>>>> than leave the field at SYS_EMU_TARGET__MAX.
>>     >>>>>>
>>     >>>>>
>>     >>>>> That's technical details, but not an answer to the initial
>>     question of
>>     >>>>> why we need to change anything for user binaries, compared to
>>     what exists.
>>     >>>>
>>     >>>> The first two patches revert the current static initialization
>>     so the
>>     >>>> token can be replaced. They are not a user-mode behavior change.
>>     >>>>
>>     >>>> Compared with current QEMU, user-mode still uses TARGET_ARCH.
>>     >>>> qemu-mipsel already reports mips, and it still will. Names such as
>>     >>>> aarch64_be are not SysEmuTarget values, so user-mode cannot use the
>>     >>>> full target name for this field; keeping TARGET_ARCH preserves
>>     today's
>>     >>>> value and avoids the runtime parse.
>>     >>>>
>>     >>>
>>     >>> Why should we need to expose this precise information?
>>     >>> So far, if those targets were not exposed (and aliased to 32/64 bit
>>     >>> variant), it's probably we didn't need it.
>>     >>
>>     >> Current git master is exhibiting a regression compared to previous
>>     >> releases.
>>     >>
>>     >> For example on 10.1.0:
>>     >>
>>     >> $ for i in /usr/bin/qemu-system-* ; do echo -n "$i: " ; echo -e
>>     '{"execute":"qmp_capabilities"}\r\n{"execute":"query-
>>     target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M
>>     none | jq .return.arch | grep -v null ; done
>>     >> /usr/bin/qemu-system-aarch64: "aarch64"
>>     >> /usr/bin/qemu-system-alpha: "alpha"
>>     >> /usr/bin/qemu-system-arm: "arm"
>>     >> /usr/bin/qemu-system-avr: "avr"
>>     >> /usr/bin/qemu-system-hppa: "hppa"
>>     >> /usr/bin/qemu-system-i386: "i386"
>>     >> /usr/bin/qemu-system-loongarch64: "loongarch64"
>>     >> /usr/bin/qemu-system-m68k: "m68k"
>>     >> /usr/bin/qemu-system-microblaze: "microblaze"
>>     >> /usr/bin/qemu-system-microblazeel: "microblazeel"
>>     >> /usr/bin/qemu-system-mips: "mips"
>>     >> /usr/bin/qemu-system-mips64: "mips64"
>>     >> /usr/bin/qemu-system-mips64el: "mips64el"
>>     >> /usr/bin/qemu-system-mipsel: "mipsel"
>>     >> /usr/bin/qemu-system-or1k: "or1k"
>>     >> /usr/bin/qemu-system-ppc: "ppc"
>>     >> /usr/bin/qemu-system-ppc64: "ppc64"
>>     >> /usr/bin/qemu-system-riscv32: "riscv32"
>>     >> /usr/bin/qemu-system-riscv64: "riscv64"
>>     >> /usr/bin/qemu-system-rx: "rx"
>>     >> /usr/bin/qemu-system-s390x: "s390x"
>>     >> /usr/bin/qemu-system-sh4: "sh4"
>>     >> /usr/bin/qemu-system-sh4eb: "sh4eb"
>>     >> /usr/bin/qemu-system-sparc: "sparc"
>>     >> /usr/bin/qemu-system-sparc64: "sparc64"
>>     >> /usr/bin/qemu-system-tricore: "tricore"
>>     >> /usr/bin/qemu-system-x86_64: "x86_64"
>>     >> /usr/bin/qemu-system-xtensa: "xtensa"
>>     >> /usr/bin/qemu-system-xtensaeb: "xtensaeb"
>>     >>
>>     >>
>>     >> but on git master:
>>     >>
>>     >> $ for i in $(find ./build -type f -name 'qemu-system-*') ; do
>>     echo -n "$i: " ; echo -e
>>     '{"execute":"qmp_capabilities"}\r\n{"execute":"query-
>>     target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M
>>     none | jq .return.arch | grep -v null ; done
>>     >> ./build/qemu-system-hexagon: "hexagon"
>>     >> ./build/qemu-system-x86_64: "x86_64"
>>     >> ./build/qemu-system-s390x: "s390x"
>>     >> ./build/qemu-system-m68k: "m68k"
>>     >> ./build/qemu-system-xtensa: "xtensa"
>>     >> ./build/qemu-system-xtensaeb: "xtensa"
>>     >> ./build/qemu-system-rx: "rx"
>>     >> ./build/qemu-system-loongarch64: "loongarch64"
>>     >> ./build/qemu-system-riscv32: "riscv32"
>>     >> ./build/qemu-system-hppa: "hppa"
>>     >> ./build/qemu-system-ppc64: "ppc64"
>>     >> ./build/qemu-system-microblaze: "microblaze"
>>     >> ./build/qemu-system-sparc: "sparc"
>>     >> ./build/qemu-system-riscv64: "riscv64"
>>     >> ./build/qemu-system-i386: "i386"
>>     >> ./build/qemu-system-mipsel: "mips"
>>     >> ./build/qemu-system-sh4: "sh4"
>>     >> ./build/qemu-system-mips64el: "mips64"
>>     >> ./build/qemu-system-mips64: "mips64"
>>     >> ./build/qemu-system-sparc64: "sparc64"
>>     >> ./build/qemu-system-arm: "arm"
>>     >> ./build/qemu-system-tricore: "tricore"
>>     >> ./build/qemu-system-mips: "mips"
>>     >> ./build/qemu-system-or1k: "or1k"
>>     >> ./build/qemu-system-sh4eb: "sh4"
>>     >> ./build/qemu-system-aarch64: "aarch64"
>>     >> ./build/qemu-system-ppc: "ppc"
>>     >> ./build/qemu-system-avr: "avr"
>>     >> ./build/qemu-system-alpha: "alpha"
>>     >>
>>     >>
>>     >> so we need to fix that behaviour change for query-target.
>>     >>
>>     >> If we want to be able to expose only the "base" target,
>>     >> then query-target's  QemuTargetInfo struct could be
>>     >> extended with a 2nd field that presents the base.
>>     >>
>>     >>
>>     >> With regards,
>>     >> Daniel
>>     >
>>     > Thanks for finding this Daniel.
>>     > SYS_EMU_TARGET already has the correct variants, the regression was to
>>     > use TARGET_ARCH instead of TARGET_NAME in target-info-stub.c.
>>     >
>>     > I think Richard used this one just because TARGET_NAME is a string, so
>>     > it can't be concatenated with C preprocessor.
>>     >
>>     > I'll fix that part.
>>     >
>>
>>     Please take a look to the following series that solves this regression,
>>     and also allows to detect endianness variants through target_arch():
>>
>>     20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com
>>     <mailto:20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
>>     "[PATCH 0/2] target-info: expose full target variant"
>>
>>     Regards,
>>     Pierrick
>>
> 


