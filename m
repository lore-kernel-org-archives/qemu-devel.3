Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF90606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a9N4RNC8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TzqkSOzS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4BZ-0000Hg-Ma; Mon, 16 Nov 2026 16:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4BX-0000HK-Nr
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:24:19 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4BW-0006AF-72
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:24:19 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfG682247144
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7laqIErXVf8OAKVn4zbSvlGi1cC0JvaaW0OvVJD1R3s=; b=a9N4RNC87my6ORQj
 jGkE7D7yMlF8uKYhLzeMsxdPxwgZZFrZheYeOeXaIvBu436vQvO9VrSxDfLliH38
 NEYZp/uYy0FcmWcO78WbTAlUm30POh/xeH4Nl5/5qp69lDDaPC2se1m3iTw3YhOl
 rnsoZfcvs12h0kunFtl9GBnYV/Fn32eYgINIwtzKQK3Vcv9BBO1cAAFctNyjKx65
 IaYmBfNFH+3rkpLrXNYsdMgugpsNWuFcoWdmLqpWDXHzXsp8jZbs35suW5gNtXn6
 gOTHl1w+LLfGudeNpItB/eksKzJt1teI/l1xoC98chVRyD+Ae6jj258ZD+faUzcg
 WESN/g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqyamxk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:24:16 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-370230d93efso3948969eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864256; x=1795469056; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7laqIErXVf8OAKVn4zbSvlGi1cC0JvaaW0OvVJD1R3s=;
 b=TzqkSOzSzA8HvQ5zw/tWhjef2JfWnAmgZZdmVHiOwFPAyoP8OwwSkSng6ARPmcE8oo
 wVurnrNJQkpBTtb5v23LtzVL6jINRv4XJlKuQCAYK3nF0BlBt0NkKHZzhwHvge3uz+NN
 8fVtLe2pPWVQ9x1tfDRB2rPlBijpvke3pf30j8SQ6vvN4OhVmBMF+ZSd5M8NCmS0Tlig
 CMgtsc03/W+c2mxphc/+UFAgHbB0Eg1u5nhirROI6z7ecuyiUIIimclZr9Xc97/00wDp
 KVqQPEGSnds9t14uC9gCe7ku3LXs9z2+b27IZp1R+yduFUB8big3Us7x/LZtQteKdL+D
 0I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864256; x=1795469056;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7laqIErXVf8OAKVn4zbSvlGi1cC0JvaaW0OvVJD1R3s=;
 b=R1FpECaq+yakadnrf/NOSkr3maVjefBblmv8bEkL2GhTfjPPmSl2HCQ3MVDLQknPUM
 1TxLU+8hYaG23N/WHkzVo/AwQ/IWSLEtMJtLwlpHegJuSGl8yaF+YW63oclChM5XsUcO
 G63/+iTZYsooCw0DY2aUcsIgrBRZACEBa9B/PizA0ym4H6GZI50vROvq7yHrvw0Mi5o+
 Lg9OsVaNeWxdSQJi4FUHutlq6n8ZgZiPflfpxeCJszIsQ1XtHwHHPvJLZ4+HU/RJok7c
 1ChRNNqK3VX6e2Rb5LZbSQQWkvlTUza75aFGIwkIqslTtGgjecz1YfaUTpm9INpTU/Qo
 MUdg==
X-Forwarded-Encrypted: i=1;
 AL+hErEmFjTmn27rvGUJhM4vxnyAo8wDsvlcYdQ8qvAJPAeXeSh/Z4YrbnGJR+BUE6hkO7IN21ItKt9etSGZ@nongnu.org
X-Gm-Message-State: APuU4Z/AC9Ev9nvuthHTcEIwtFtpaLpJMWFMfcULlKu6MOiviA6Z5vVH
 bPqJO843OVouoigBzlPiP9GNPGg9HjkeRAvTuV7Zz4bOKl9ug3+JEyHiQVUn6qr4OR0CnwYzDC8
 dQZOj8Sp+qxzmrBw8ItAO2995OWQjGQZgLPwygNZYPYpgsiXJX8/uO1HcNw==
X-Gm-Gg: AZFdTZcWSghnWq3uM/W0hsQLlP/xxgoBuSpf8cSeHxFZk/A5VpUIwgpFL/5kKebazYd
 R2ZJoGL25jbScOsRykiH8MTDIPQ4l+KhC8l0nlb23jtaz5e8uF5IT7MjyPutraNhknBg5qCIAfT
 TYh1evNfnPI+1ICQe741/++v3JdV4jh+v7YlhuLuN+ZykQT9c7CJt1TJi7gtPszwh+h8bskah6C
 jq2ds6H283b4uPcFwq8vIwM8kY4p7fTg1GSXwLAdbRlbMVIGpDD1kITPMrgJfxbEWHb+gaSngEq
 6YtVd2rfJI+/VrUrk3F3i9wg9lElBpPuj8IZOXxYQSDR/vEIjphUZkeQwAlzXt262JjZKB/q6Z6
 h6dH9NDYIspy9CiVmC3eor1EIpgEbZ9EnIIvbzAdpxGyLGqGHtfwE7HVvqrC/vgOxJmrV1FwIT2
 Pxk/N0KK4BcDUZA3lFKCEOLPcsT1K1tTwBQpUzQJVlAIo=
X-Received: by 2002:a05:7300:d718:b0:36a:12c1:3adb with SMTP id
 5a478bee46e88-37966b52740mr17344781eec.20.1794864254246; 
 Mon, 16 Nov 2026 13:24:14 -0800 (PST)
X-Received: by 2002:a05:7300:d718:b0:36a:12c1:3adb with SMTP id
 5a478bee46e88-37966b52740mr17344765eec.20.1794864253716; 
 Mon, 16 Nov 2026 13:24:13 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316f2sm38333940eec.9.2026.11.16.13.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:24:13 -0800 (PST)
Message-ID: <e7985586-9748-4fc9-839e-a980987c1bbf@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:24:11 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/48] hw/core: filter machine type list if a target is
 selected
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-33-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-33-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX/wpYHlklJGWn
 tEWEsZJhy3gGdNNlELMN3j5y3tLDavrsYCgyOLB0p/JRfbDSGeXAeRWd7zqzSMMkT17gacSbuaX
 U1MMNWFTPxC9B0LvAvXTGqiw06KZuSQ=
X-Proofpoint-GUID: vk187uWSUJLF3uZWikyxzr-lYBEVjHH9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX5Fcpq8GqSCgW
 SPRvfOOoYdGaknaj/MQt+avqKj4imy7wyWZZA14m6WMd9oAG1acO8feQLDatDf+329fp6emrvH5
 6ClLg98Ck0t/b0sWEsnX3AJ0u6CmjdkYzCwX2VqJb8OWXKRzZhEhoKX8dlVVsktiGO8X2PWdpVC
 bQBo42FheSCrWBUUPNMRpkpZWUgY1pFgHA0giw7oypvdjeUcGLfmJVhCzX1cOhPXBcWyL+124Gv
 i5JIdi2vXIfO5vj/GLCHzNTv9gJ9zpTjZlGwzza5Aas1Jtvk3Sxnp4z4TQDZF7wSy/5JuQmK/P9
 TWiUIkd3EbPaWDxue2ghgQddMcWGowU0rIYYA9HCYCwcWYx+ScUfPUrwMsfGh/P6YE2aAVS1d3D
 HU/NgbvNxuJbPkYUjIG8M+fRYzDnYdx1AtyYO2XnnvlcvGpg3cfYqfWqgE58ZR+CAW/+RVQVQPc
 4SPnu3oxgnttUi2rqMw==
X-Proofpoint-ORIG-GUID: vk187uWSUJLF3uZWikyxzr-lYBEVjHH9
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6afb7480 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=5nYmEGmr3W0M4u6KcIUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160085
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> If a specific target is selected then filter the machine type
> list, otherwise report all registered types and aliases.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/core/machine-qmp-cmds.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

