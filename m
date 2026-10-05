Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BE4CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDlAl-0003jB-Hs; Mon, 05 Oct 2026 12:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDl9w-00036N-VN
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:03:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDl9t-0006LY-Bh
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:03:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EP3Vn3189025
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 16:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X4sq26nlQaEQcDQrE8c4FS9guAn7Sq3a35ydBeanLv4=; b=l5elGPZ8JEgO0JUV
 5yY+g7DQ8Fz+thIcXDLnt/dP5ZoVN624JsB6428qa3YTQ9h6SV4IN5VxDuAndLEr
 Mtp5hG3QDcigKCAvlx6Tthir4jizipe/FARMnd2HiNgTJ6zz6yk/UFCkh7zfyqY+
 PfYU6AX92r04drhIB1P2q3rqXGfRrg48Z3UTuVIg1cPTurXves4Uejl9JRvoKOQ1
 vJV0I57sd3VYlpd9vz2sSy46AAu56E0HfzQV0wZkFkXkrf7WD54k24OlucX9hYKj
 hkb0a3C9vv0TsTSMk1+k7ijq2hkJJ0CYZ7aow2eCL1CkzqBr2N69O0r13wplt/yW
 vyckDA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cuu0kfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 16:03:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso3761481eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791216197; x=1791820997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X4sq26nlQaEQcDQrE8c4FS9guAn7Sq3a35ydBeanLv4=;
 b=kA6YgMq9dXR2KDUeO/iZlcxrY4c4xySaNYIAgU2gyh/3ZslJERe0Fzdj/7PjGj3Ft4
 +K1OPGd8Jki9Xv1FfFfLUEp8+q2oLMsy+kaJ94EuM60fQGrHxbtqWYNSS4GLyhVkVTU5
 TNXzbOOMkPLLCfFvu6Fbsb5a918yFoG6iu/kV5+aiteU4BrZTUlGncInB925Ufva9uRF
 WoMf9wi55RS12v0tm+rezKIp4JsoMUYWHxGNigRxnCa/I2qfO4mkUE5RDs0XtTeh+eMk
 xQTqNrZAbWVHgIOXMqAYaeMV+IL4wPsJdY3RO2nYxVCSMbloNklyrC2VrzPnsEswfUuZ
 uyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791216197; x=1791820997;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X4sq26nlQaEQcDQrE8c4FS9guAn7Sq3a35ydBeanLv4=;
 b=xp/gwft9mmjfTHa0E+aEILrelBkfGHEFVLkRygdYdEV/7eTgff4rzn2g/5DldPCznT
 0fu65RA7nZW+D3ajK+FCh40uvaYIXKhA/JieggUlgj5Hfsz1cKXOK4Ol83rQDssAJoKM
 7/HW3ddhA4vQ5PYfM0ko+J3s4rF/7NPLoasaA5S5fpggX3QsFOKQclzGrREa4wSuqgKa
 2WdXU0JNvCzcXRkanEaPZp+jG5a85C6yrmnXMBCw/JKrr8SzcjYCHYlMmL70t7YCwPmU
 pAHj3bXoIl/IS0VboZCRVuCnxDRQN22YHitOxK6jw6w0zjoaeerxpX9um5KV60XXoc0k
 4wfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxG1bpa7XX88nJL3txLXBqlHuB4fcdNiQ/22imSeVq1zQAQX5f7g7kaXkBoVx0d+cWtHDHWBa0qua3U@nongnu.org
X-Gm-Message-State: AFuF++mqQsk3I9nsSrcvzTKTD7yYTMGGEx9FoaTz9DcgMm73xKHTSGlY
 iZobCDXdu2NKErWyPYnYt/RNMQqVQxpaqiQJEN1KD17a0f3KUGSRtshIkm5s4LAWmRTj3GGrLJV
 uWomlZzzZMrk9uTR0K3cpe9lYtL9tXKPfi9xiMunRBRCwx3qJrJy5USMq4g==
X-Gm-Gg: AYBFou3ceczvJexpGg9RyS/F3zwn62FiPncM0H/8gtmgtq11AT0Bn6buik4ShpHoAmD
 3xrwDKPRCk4W6duHQFn8eZ0wQP5R0xknLxtsgxS42oplMf40dRyp3FCzzTges02+U/pbj3L7snW
 OOiv1caFzQE3f+Nqa9jbg/wJIaVgvFz2Z4Ivn1bldQluEg07e/1DCBxrn2q4uURXtj+PVtJlAds
 12Rt/ADUgRrZCblrP5GZeiCmAj1SilsG8j+yevbce7zTrnfa4TmFA4dwnIFYWoPlLEQdB79hwQE
 Elxe8lv+87fhUjay2V+cyAl3ndQwmW/k1IQRRPgSR+GIBgt6LXmzaXTr/4ElmDY/lzl03MTzds/
 X6vbG0YRBVYFlzVSCyJZEEVUWbk65zZm5PQVmWjCPwmmTMW4KJYlyg5JM37C5oq5oAvnKkw==
X-Received: by 2002:a05:7300:3f11:b0:346:7c2c:1d25 with SMTP id
 5a478bee46e88-34f219c110amr15749234eec.41.1791216197224; 
 Mon, 05 Oct 2026 09:03:17 -0700 (PDT)
X-Received: by 2002:a05:7300:3f11:b0:346:7c2c:1d25 with SMTP id
 5a478bee46e88-34f219c110amr15749177eec.41.1791216196440; 
 Mon, 05 Oct 2026 09:03:16 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127138638sm17993631eec.8.2026.10.05.09.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 09:03:15 -0700 (PDT)
Message-ID: <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 09:03:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261004072927.1142-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MiBTYWx0ZWRfX7f0GobNnEWI3
 6ExtIOSTCgOKFfxSDXiw55iMTW4OoHkjHj4dTQfOPZoBcOUUvgUOXO+G5WfUh/iQoB01UlEGaGP
 a1t8lrynlS6Z0mWuDPXyIFf8M4XzJ2k=
X-Authority-Analysis: v=2.4 cv=aKRlOr9m c=1 sm=1 tr=0 ts=6ac3ca46 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=i98RhIlu5PmTxgjNvFEA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 1iqbrgujAqVuc2WV1zWk9bjBBYi0FMp1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MiBTYWx0ZWRfX5p/wkcEO5MX4
 s8JvIkyEsP02IFS/23fZ8Q456PqG8lba1UfxviIRy5yFLnmJ8Tl/7y/DlwGWwJ0vKXsdUqm11pC
 0AgqS4O3WOGIiLeBI8CpRUEJAWWyFD8ekbdDe0jh80IEGRM7ykPTvx0XgmhclXZeGGl/KvbEnun
 ECO7ElrFbwWA+K2Z6CmPX8MgIiseBFTNo5vbJpqCJOKDBfBdLs35OTkxPxto5c7pxo+PeKnMC7u
 NY0PwWV0ALcNfObBTJtB8aJxzXSzwQTdfOyTz4WM6xU5w5PQCwxCKkxrQhNLoO2DeIyL1cksc6f
 MyNHnkCR0zn6zDMyknme/HG5TiMU0YJxFvPEOcKOhY/rPgbHcDsREXK7u+6bZQvNWt4wv4b0bhX
 /rJJO1sG3S2OW4K5LC1YHF1Qc799l9eaXMEl9dXACYcnURqEaWZp8JRNBGeimxVnPr4M7bGCoRD
 qlqUa9jr72tXhE/7OTA==
X-Proofpoint-GUID: 1iqbrgujAqVuc2WV1zWk9bjBBYi0FMp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050062
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/4/2026 12:29 AM, Yonggang Luo wrote:
> `TARGET_ARCH` identifies a base architecture, not necessarily the full
> system-emulation target. For example, `mipsel-softmmu` uses `TARGET_ARCH=mips`,
> which caused `query-target` to report `mips` instead of `mipsel`.
> 
> Generate `TARGET_SYS_EMU` separately. Softmmu builds use the full target name,
> as `SysEmuTarget` enumerates system targets. User-mode builds use
> `TARGET_ARCH`: user target names such as `aarch64_be` and `mipsn32el` do not
> have corresponding `SysEmuTarget` values. This means `mipsel-linux-user` now
> reports the base architecture `mips` rather than `mipsel`; its executable name
> remains unchanged. Initialize `TargetInfo.target_arch` from this token and add
> a qtest to check the `query-target` result against the target name of the
> running QEMU binary.
> 
> Yonggang Luo (4):
>   Revert "target-info: Statically initialize target_arch"
>   Revert "meson: Add TARGET_ARCH to config_target_data"
>   tests/qtest: check query-target architecture
>   target-info: preserve full softmmu target identity
> 
>  meson.build            | 11 +++++++++--
>  target-info-stub.c     |  2 +-
>  tests/qtest/qmp-test.c | 13 +++++++++++++
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 

Why should we do this for user binaries? Current work around
single-binary only concerns system binaries, where all targets are
correctly covered by what exists.

Regards,
Pierrick

