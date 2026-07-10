Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F69CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJr1-0002Ny-BV; Fri, 10 Jul 2026 18:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJqz-0002Nj-VA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:37:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJqy-00063E-Fm
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:37:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALClmg1931565
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PERBNSexsk68uw//dOv7XcVMIsN4pCCHhp63AA1mQ8s=; b=D3fnICrWaZ3cpu1R
 wqrUzhm6xmiYt8m9DK0+dBfBc3iidUq3k+fRW/vlWD1UU1hoQCLby/pnfnnOq/+z
 Uk0LojjeU5NSivzj/9spDFhfGO351CeJSO+lOlGgr0IsiYRJvT+V03ceoc7O+elT
 WHRCIjaLdcV/ZVAaRtzYQjAP9M8mGK7z3TXaEo5GPWN1om1vX6icDHT6M1v8DXZw
 A0T5fK88VCbktfxzsdr5WMs2fpZJ4I60hKIjblEdMR9rfBFvo9sUh1KCIONmSVlx
 Oc8Bpx7xw+7Wtweot1rBjblja73zpspa38TDqyrv9kkLm1pqkrbyv53qIRanmX6k
 6vrdvQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r7ac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:37:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso19374351cf.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783723070; x=1784327870; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PERBNSexsk68uw//dOv7XcVMIsN4pCCHhp63AA1mQ8s=;
 b=YF2Ceiq9YjsO6JC7ZPmDVytS/3jsblztMV6AkH8DiJ2D1RID9vO9Tr3xeKlqrFc7DT
 Av2MUknyPYgl/7F8h0wPGWrxqhZJHpR9JRM7XYADf26g7QKCrSqI9tTLDyO/zDQghzcE
 UwCtyYyggN/BernDr+ct0wd1SBl1AQKYuyXYqL+EydjhDjEgDYk72M+yr+lqmOLiw73q
 +D/pAX+kFvjauOtm2a8uZw3msU9gqB5pkv6cRc9c/7oSSkYpVAm7yDrKFMyAO0NemWq+
 4zYETDVEAtoMQI/Ii9xZ9VxBU96gCAsYTAhLNbChKwj/c6HE3NvJd5Fgy0fa125mmmHV
 vdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783723070; x=1784327870;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PERBNSexsk68uw//dOv7XcVMIsN4pCCHhp63AA1mQ8s=;
 b=rx2Lqkb4pcDi13dV7wAtSOpzOfTeSzRJrNKYaN+wBvMk/08rKYNLzQhO9X2y90QhIp
 THX2RhWxvJqhunaCaT1RLQ542c6z84aDyethnjYWYHk/8mWsYmWCWJW2hH6ntNHG77yZ
 soXW8hZUjGcmGmS+4/8wmqZn5gjOPKmsmTliDllGkgovFxXxBK48SFpl7TRb6uawLPYT
 PXquLZl7KEnOqpdTG6rziTn5chYKSuoQP4DJUw4S9uKWIO0smV+VMoOmJaOLjeicY5MW
 sPSdx8VqxvtfbM/a/RzRxZeL7kN0dpgtOIsBJCwD04hJ7EeVTH1Q5KDm/QQc4J9fH80q
 pdVg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpu6hnBw7fIlQWp2bwaH0QLgYDlR/Q9YidXORXZwcF+Rq8JTuIPwXbOantHDyynsZsEMFnlN28nwDo1@nongnu.org
X-Gm-Message-State: AOJu0YxjlMO1vlgOGQcfjLv7RDQKcGDGN2CYq7tAn7W2KVNbim2QUeA7
 V0rrXnr6a6SW9Qf7gIrvUwYrI0APR4/l0cWn0B5FdI5CNpO0gdvHXeZxqSMdTvls0FOrza/1NkA
 lMNmlnslu45fwNmZ2f4r5mjVleSDAm8McMS4B6fOB8jw5ZoVI1pyjXkB12OjU26diSQ==
X-Gm-Gg: AfdE7clb+cgeJdphDn4UhGqtM7vxy1CgTAZqtqqeJfsksgvc8rQjVDeY+YeblaQ5FaC
 vdCI2ilvporCO+VBERokcb7ljc85ke3TXYZ1iVqcyGy7SQjjzfnR2T8vtuYLnFzpEUJgg17F/9v
 zP6xGVF0evXcMt6cfupTEwXspmRGURLZ2MnIVl3KgUYgoVASrHCkaWRg0zPw4knFpVl3cm4FSh6
 MXkc9rZccdecMoCER1W1Nlc37laz12s4Aj7+GvuiSw37w6efbg7zBAsiZBfnPWfoX9H5MK39egQ
 U3+4+2ZGNag9HmYIRg2PzdE3DWRxc2e33dsrFXBZvBPP7X/5Tc702bGIhNbVGXfrNhGWqovVzEi
 sLOUD29Be+hMKwPavrdoaEtUBmG2wuexlAGqavY3s7421+RYgKmZQ5RSnV2+onQ==
X-Received: by 2002:a05:622a:104:b0:51c:c29:d4c7 with SMTP id
 d75a77b69052e-51cbf2f8f87mr8244101cf.62.1783723070624; 
 Fri, 10 Jul 2026 15:37:50 -0700 (PDT)
X-Received: by 2002:a05:622a:104:b0:51c:c29:d4c7 with SMTP id
 d75a77b69052e-51cbf2f8f87mr8243951cf.62.1783723070216; 
 Fri, 10 Jul 2026 15:37:50 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3dcdsm163621795e9.3.2026.07.10.15.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:37:49 -0700 (PDT)
Message-ID: <55053d11-91f7-4917-85bc-0c3efc2026f4@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:37:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 98/98] docs/devel/testing/: update documentation
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-99-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-99-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a51743f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=4IVPZc6mT66RUkp122QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tyGbBhsY_L2Cq14qPyL2J88xbN48Hemx
X-Proofpoint-ORIG-GUID: tyGbBhsY_L2Cq14qPyL2J88xbN48Hemx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNiBTYWx0ZWRfX0hwQrOIIOqgC
 9uVDC5F4ehAsONc8Ecl80M65AsFAe0la7mVXaukVmQKRd4EdXmnCA0OxQVGZayNjmHD+6LO2lJO
 lj09dQ1Y4i9Cgf7qH+MBuonXE6iaXMo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNiBTYWx0ZWRfX7g0F7mtLCM4r
 mRXw1980LBJgpXIA1Z2Y3KLAInEA8E0+o9V++BIVN0VCAXLbVoq9As+jPJwHDxT35NMk5GOqnNC
 cYqZm0dsx3+YNcAlpNmu07FaTqbFxjuyjTI4j6TdPhXge6GMPopVWHzcHB6Utke8ESU7TF6Ypmh
 Fm9Cbx0OzmfQTtEBUf+Fg0QZF5yyhclQrubEKnEZKRTXwmQ/mn8dXVwI6Lb4fBUYsQX2VNTQRs6
 dAZguvuBGfjz9rKH68P6OjFgdO5Gg6GUHIFkHgoDP3U+fhpWJGvgeQ2JxlVzsqMWg65aCAxizDq
 S57DJ/k3qAoWXeQnPYQX1+gQFln8LTVRg3l3Gt/HKEbjrvwhOM7/OXsiheGDea8nJIDG6FQeY6L
 2wRAqcg5g/AnWzgoLitURsAmiCYqjgLttVprgBbAAEZkS3r3Go2Wmcr17Xz9533JOvlAad62Dzj
 8p3vYEhMPbCuxWQpJzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100226
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 10/7/26 23:43, Pierrick Bouvier wrote:
> We document how to build and run tcg tests with new framework.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   docs/devel/build-system.rst |  4 +--
>   docs/devel/testing/main.rst | 55 +++++++++++++++++--------------------
>   2 files changed, 27 insertions(+), 32 deletions(-)


>   Running individual tests
>   ~~~~~~~~~~~~~~~~~~~~~~~~
>   
> -Tests can also be run directly from the test build directory. If you
> -run ``make help`` from the test build directory you will get a list of
> -all the tests that can be run. Please note that same binaries are used
> -in multiple tests, for example::
> +Tests can also be run using directly meson test::
>   
> -  make run-plugin-test-mmap-with-libinline.so
> +  ./pyvenv/bin/meson test $TARGET-$TEST
>   
> -will run the mmap test with the ``libinline.so`` TCG plugin. The
> -gdbstub tests also re-use the test binaries but while exercising gdb.
> +For instance::
> +
> +  ./pyvenv/bin/meson test aarch64-softmmu-hello
> +
> +Test command and output can be accessed by using verbose flag::
> +
> +  ./pyvenv/bin/meson test aarch64-softmmu-hello --verbose

Nice :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


