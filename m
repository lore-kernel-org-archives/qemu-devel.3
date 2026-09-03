Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89856C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x23ua-0003Xj-Ao; Thu, 03 Sep 2026 05:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x23uY-0003XH-Sp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:39:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x23uW-0003H7-Q9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:39:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683931SD519720
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 09:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lHMUuvMWB7xg33KHVQxIBatpfSWWYsNXxuLhrU6WUKw=; b=RmBqDwAE1ynPWZu2
 B8mqlZlJbWe0nWle6NpDRsyibs0TlmzOWo7H6Y9Dp66OoHbkQi92haf5g+zhywPg
 s+CCrvuBDACFTQq6HNoblEnAcSvdA9pU2Ib+kKY9PoV0ZoVeTuyKVdA8ERZsyzvN
 Nr/wjnf7df5OVywoCKe1pLYDimaHa3plRw90O3e59KjOXEfhbG+qnZlK8ekcE/rH
 f3U/TpfVLjWD87p8NKUatxB4UgxYk5Qc2pc1ZaxjuWdTR5XICOPmmbmSZxL3GarQ
 2h89vtm171kZj6DKaAvQ7yOildi3GiDsuIkqlue5/I+qckD0gERa+6ST7z9SkvcD
 jEp92g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4h8b4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:39:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936708f129aso340004085a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 02:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788428346; x=1789033146; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lHMUuvMWB7xg33KHVQxIBatpfSWWYsNXxuLhrU6WUKw=;
 b=HFOkfX5g6hX1/bKhJCkka2W3K4xJKfFbOmx0dP3Q2fiAz9Yqi0oZ/CECSPTBl3HLQI
 zu1Ukh5FC3AyMeBAKENub+1lk4qCECt7r2J4ZimfxyWgxuIhwhJ1u55TVuiJ1pkYAwis
 sFdFYLPU0RsgOAxFE1aqaduaZEMH4W/I9hHu0v9t7URHhsTr08olMTy6dc8IlrD/u9ED
 hEZMBcrUpUEXsXgBKcnN2kYzKOERipHHIdR0+cHSeOcwGRj20Cz328zeuZH37QPuyBAW
 27au/3Vdwt67Hwnx4w+7AIxoKI5Z7Oz/gyWqcaWt+46tdI7FATkXIXDE4bakLCWssNCe
 TaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788428346; x=1789033146;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lHMUuvMWB7xg33KHVQxIBatpfSWWYsNXxuLhrU6WUKw=;
 b=LFw8ScW4sY01fLOnoowZZJk5uLyEvZptDCXdGyTZQgCMawbZRn6GEQ0psxJ9vvg7Ic
 FFj8VBY4ARS39Rg7UbQAqk5Cn3Zwo81wAqoA35OBCixCZ1TaQ5DEl0udda1nIfU9XzcH
 yOZumU/u+51y5BXwYsfQSEPvaplZgJ4N3InehrcfETPdS/5uAyvvXx0E/EUUpb79OtMP
 HUP3fr4U0nMYm+TJv4TY6lW92GKOosRWTn84NxCvULaKNPkAyE2uenAB9UNcbYUMte/t
 ZdwvOHELkxOZHKdqYzvvQiiZ79cSBGwob85Q8XNW5j2jDaRNbWtu0GgZnIHbaBIiIrqT
 Aaiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJsRjdndcMLTD4uahHn6OUrnvZkPtDm3BIDY+WfqX9RWJcHfutCiUCQ0CbXlB2iziAoflL+NyGUh4r@nongnu.org
X-Gm-Message-State: AFuF++m7ZYrHg46x8XtNDDsXnu76V5HtaGVluplUk43GMn89N90YTsfI
 WDuLMqL6GCudkJqJuxOEwoHdKzPkPqndOGo8/Yv2SFoAqT3Pd5ksp+TjvnXlE+QpGoyrbCR9mFC
 MCASJvRhARkHrTaYoLGF4dNroSayuFYTZRXuy4o+riSWRm1Z+xbomrrvtHg==
X-Gm-Gg: AYBFou21GE7seIDLCy1Y4kE024K2sJQOf0jmuKuXWEgyKcufHaEJvOtnhxPVu8cHYFn
 gyBlSYx/46f+PcVQ5HRfTMXobyZWOe2Jc1bSWkniVOyfkSWFSnarw43K0sej8SarNdmG3xvBMvT
 l8Ap8hO0wcEPKdgXWfGZxBLHiH58Vi7KuBdA4e0MUxr7rupfmPOijgZSUho8AhsRHfjE5WumMdW
 valFgAaDHw9EnaA0XpLba96p3ZdvBqHVG2ECgXdd2ouCAewD7qIyn52jE7MRuD695I8EWlou+ke
 9++ONQtYUr1hfz3uv4iLIc9Ul6oBEIoyKa6XRl29h+S0fLFn15htiMh3pZXpjrWhJHnHJxqLHJ6
 7SJLAZYwvC6iky1VA1rvJhrc1sEt9exiprw==
X-Received: by 2002:a05:620a:2724:b0:938:e23a:2ce9 with SMTP id
 af79cd13be357-93960dd83c3mr1347723685a.16.1788428346482; 
 Thu, 03 Sep 2026 02:39:06 -0700 (PDT)
X-Received: by 2002:a05:620a:2724:b0:938:e23a:2ce9 with SMTP id
 af79cd13be357-93960dd83c3mr1347719485a.16.1788428345877; 
 Thu, 03 Sep 2026 02:39:05 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5e589bsm53377495e9.13.2026.09.03.02.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 02:39:05 -0700 (PDT)
Message-ID: <048bfef9-53dd-489c-be73-85e2c9f759a9@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 11:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] qtest: add xilinx-zynq SDHCI sdma test
To: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260715160731.29969-1-dingtao0430@163.com>
 <20260715160731.29969-3-dingtao0430@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260715160731.29969-3-dingtao0430@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a99403b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=Byx-y9mGAAAA:8 a=gDqya4-GI6UjnyQPRUcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 5DRBy09_xZ6PnbhaBQN1-W3ywWqbZTcQ
X-Proofpoint-ORIG-GUID: 5DRBy09_xZ6PnbhaBQN1-W3ywWqbZTcQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4MyBTYWx0ZWRfXwIrBgkj4h/B7
 gd0LbNdH5KmrEXQthxqj89RY0M6Ej+f006Z0U32MAkGCygr58fRpJdAcOBBDOocnjmcdSjtDb2R
 7iWinQ5QP5bnRC/lI2tXiMVknI2lDxY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4MyBTYWx0ZWRfX0X6hzc6nhQqr
 X0n/6tBs6WanEWwagyC0c50JL0n9sJPp0bZd7Df40o2ZP+G3mlJbME/YffMCZOFpiBfDt7f8Q5O
 oC/JWRyTb20Nw3+TtS63b7JQjYUCz8JisvRAcyqYCfJ2GwNBSw8vM+2bGU7T4HXEWmiRNuugdJk
 c8gnntel2Ezl1wfa4VQiHGUj1gmyR6o/foVec524m/OpEtMDrgng2ccOHAKFBahCMlkIQYjohWl
 mGk0WD5yPdZkW9qBe6pevUJbsIaQuj2oasJu3tMNXtb47rawWDBxB6cbeAsrb0DutxbxV98RYnJ
 wk5Km+wRKxdmvqFp/eoiR/CdTnbJowqvUzC4tYosG47F9qLp58ysvuIzw0wrYCwPdah6AWET3xB
 dmCSIi8ShjZ+Y61O810LIRy1rY7GTHpBaYlWE00o12ysGcbgr9QwhzWqDDcCohrjR6KUahK8qGz
 mxCR8SsxgUWXGXIToPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Tao,

On 15/7/26 18:07, Tao Ding wrote:
> Add a standalone qtest for the SDHCI controller on the
> xilinx-zynq-a9 machine.
> 
> The test covers the SDMA boundary continuation case for a
> multi-block read. After the controller stops at a boundary,
> software updates SYSAD to continue the transfer. This verifies
> the generic SDHCI behavior that previously failed when the
> continuation SYSAD write was ignored and the transfer stalled.
> 
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
> Build:
>    mkdir build
>    cd build
>    ../configure --target-list="arm-softmmu"  --disable-slirp --enable-debug --disable-werror
>    make -j4
> 
> Run:
>    QTEST_QEMU_BINARY=./qemu-system-arm \
>    tests/qtest/xilinx-zynq-sdhci-test
> 
> Before the fix, the test fails with a BLKCNT assertion:
>    ERROR:../tests/qtest/xilinx-zynq-sdhci-test.c:90:wait_for_block_count:
>    assertion failed (qtest_readw(qts, XILINX_ZYNQ_MMC_BA + SDHC_BLKCNT) == expected): (1 == 0)
> 
> After applying the fix, the test passes:
>    ok 1 /arm/xilinx-zynq-sdhci/sdma/read-boundary-continue
> 
>   tests/qtest/meson.build              |   1 +
>   tests/qtest/xilinx-zynq-sdhci-test.c | 178 +++++++++++++++++++++++++++
>   2 files changed, 179 insertions(+)
>   create mode 100644 tests/qtest/xilinx-zynq-sdhci-test.c


> +static void write_pattern_to_image(size_t offset, size_t len)
> +{
> +    int fd;
> +    int ret;
> +    uint8_t *buf = g_malloc(len);
> +
> +    for (size_t i = 0; i < len; i++) {
> +        buf[i] = (i * 13 + 7) & 0xff;
> +    }
> +
> +    fd = open(sd_path, O_WRONLY);
> +    g_assert_cmpint(fd, >=, 0);
> +    ret = pwrite(fd, buf, len, offset);
> +    close(fd);
> +    g_assert_cmpint(ret, ==, len);
> +
> +    g_free(buf);
> +}

pwrite() is POSIX and is not supported on Windows:

../tests/qtest/xilinx-zynq-sdhci-test.c:71:11: error: call to undeclared 
function 'pwrite'; ISO C99 and later do not support implicit function 
declarations [-Wimplicit-function-declaration]
    71 |     ret = pwrite(fd, buf, len, offset);
       |           ^

I converted this method to GLib which is much cross-OS:

-- >8 --
diff --git a/tests/qtest/xilinx-zynq-sdhci-test.c 
b/tests/qtest/xilinx-zynq-sdhci-test.c
index 601b9140834..7957358cf5d 100644
--- a/tests/qtest/xilinx-zynq-sdhci-test.c
+++ b/tests/qtest/xilinx-zynq-sdhci-test.c
@@ -58,19 +58,26 @@ static QTestState *setup_sd_card(void)

  static void write_pattern_to_image(size_t offset, size_t len)
  {
-    int fd;
-    int ret;
-    uint8_t *buf = g_malloc(len);
+    gchar *buf = g_malloc(len);
+    GError *err = NULL;
+    gsize bytes_written;
+    GIOChannel *chan;

      for (size_t i = 0; i < len; i++) {
          buf[i] = (i * 13 + 7) & 0xff;
      }

-    fd = open(sd_path, O_WRONLY);
-    g_assert_cmpint(fd, >=, 0);
-    ret = pwrite(fd, buf, len, offset);
-    close(fd);
-    g_assert_cmpint(ret, ==, len);
+    chan = g_io_channel_new_file(sd_path, "w", &err);
+    g_assert_no_error(err);
+    g_io_channel_set_encoding(chan, NULL, &err);
+    g_assert_no_error(err);
+    g_io_channel_seek_position(chan, offset, G_SEEK_SET, &err);
+    g_assert_no_error(err);
+    g_io_channel_write_chars(chan, buf, len, &bytes_written, &err);
+    g_assert_no_error(err);
+    g_assert_cmpint(bytes_written, ==, len);
+    g_io_channel_shutdown(chan, TRUE, &err);
+    g_assert_no_error(err);

      g_free(buf);
  }
---

Regards,

Phil.

