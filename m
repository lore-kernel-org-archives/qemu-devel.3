Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAE2C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 12:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3DkO-0005SS-Iw; Fri, 11 Apr 2025 08:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3DkJ-0005Rw-VY
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 08:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3DkH-00024M-KJ
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 08:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744375472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FThB8YscqL3yiyYphrVewK3s1amAaeIudlJ+7pB38rg=;
 b=V/BobPbcQSxzf5IwJIvPUAiUHiKuiQ66Y9qyn9HF6ThnPRTMVdHhSPNZbeNOkYPdH58c9O
 yBoCDBcpK4t2XsO3tcknaQnde0DSgfEcV+EZ83B0+WZagheF6A+Q8qmTlyZt6W8/Gndk7a
 1VnXOk7pvwoAE71314c69eMeY1OFPNs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-VkFMvUBjP5KM2vZowNisGw-1; Fri, 11 Apr 2025 08:44:26 -0400
X-MC-Unique: VkFMvUBjP5KM2vZowNisGw-1
X-Mimecast-MFC-AGG-ID: VkFMvUBjP5KM2vZowNisGw_1744375465
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912fe32a30so854260f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 05:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375465; x=1744980265;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FThB8YscqL3yiyYphrVewK3s1amAaeIudlJ+7pB38rg=;
 b=fBQ8ubdcyoIVEVz+1hAmz8iNv8++M+iT5csbWDup0hPO9kq+vZb5PzlKQgGEo9roXO
 nKRe0TgDCLq68SVCTATw7MtrSnYx5fcvquoavI5w4Edqte785PAt5qCHTM8SDfhkaKEZ
 64S4WaBSeJ/7OwT8dIcQQiohL2AFEUf8ZW5R5sDuFRPCMcV24GynIZ1egV9Ln/UcFDhz
 3gc1bO0DXmKlcbxJIrsN6FMCpTkM9mth4zFcq1nPOWgfsqst8GJDrdD7YvO9NYhIgXsk
 GHRU2OL/9DGO7AqyWeXXip7wwrMfyXJd4m+VFookcLI2mnBDPnzLn6AVujfxo29guA3b
 YDhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTeEhNZIY7fMXJiKmE61h5xxilAJahVyzLDnBORkaQSpH4xfbUswHwDFcjKb58MOE/bBvBmPH+Dj+u@nongnu.org
X-Gm-Message-State: AOJu0YwTmp0p48ZHCloWYDrHl7JsnirkAZaXcmj+J6mF5GTGfdWt575i
 0xwNjBRB5Sat1jVpsq4Q3QIK3oAHGdbXHG8v6jUSWcxEyDIvxPNnCgMCkCPsPpi3hUujVBQL4w+
 N2yKt73XMDKFgXN+pvj7QE7s9aPUSikNLelQSFyrE2ALV++TFTHR9
X-Gm-Gg: ASbGncv5eM1rnwd6dYtvpBM8eOh/AJ5XlULQD8ZmmXw2QO3tCeU9aDVoGLwKXG9RVLW
 t2po+l8hayPtikIzCYnHD8uEnhB8xPtb6gzI1hu9lbZbt7rejK0brEAAp4D0Nn+Rh2vk7DhClBj
 NBaRzzKWNeDZNAW7rsJuazrizW6t2Q1PUL+jfOHimDAVv9iQTSp3W7OeeipXPkE+ej7uGkYJfxG
 AAu7KQnfVCaVNYWBhqHz3fKQFQINV6h3Nqx8MDLGI3C4PHlc8FLp2jXBONVaUlYGZtUQjvOks//
 3/YsN2C1S0ayRXR/JGMFyq3Y+7isBPKfMEp0+B2egR8=
X-Received: by 2002:a05:6000:1447:b0:391:3988:1c97 with SMTP id
 ffacd0b85a97d-39ea52036d2mr1928301f8f.17.1744375464720; 
 Fri, 11 Apr 2025 05:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQgQkJotAOv6DizVZeYPyYGXAtb4+2kqA7SlNL4lSrBOXFqkcSLKBIs0UrAc6UaCQuOBzyQQ==
X-Received: by 2002:a05:6000:1447:b0:391:3988:1c97 with SMTP id
 ffacd0b85a97d-39ea52036d2mr1928266f8f.17.1744375464196; 
 Fri, 11 Apr 2025 05:44:24 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae963cb1sm1935758f8f.14.2025.04.11.05.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 05:44:22 -0700 (PDT)
Message-ID: <7dcb88e6-ab8c-4fa7-bf3d-8738b586dd34@redhat.com>
Date: Fri, 11 Apr 2025 14:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/24] hw/s390x/ipl: Create certificate store
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-3-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250408155527.123341-3-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/04/2025 17.55, Zhuoying Cai wrote:
> Create a certificate store for boot certificates used for secure IPL.
> 
> Load certificates from the -boot-certificate option into the cert store.
> 
> Currently, only x509 certificates in DER format and uses SHA-256 hashing
> algorithm are supported, as these are the types required for secure boot
> on s390.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
...
> +static size_t cert2buf(char *path, size_t max_size, char **cert_buf)
> +{
> +    size_t size;
> +    g_autofree char *buf;
> +    buf = g_malloc(max_size);
> +
> +    if (!g_file_get_contents(path, &buf, &size, NULL) ||
> +        size == 0 || size > max_size) {
> +        return 0;
> +    }
> +
> +    *cert_buf = g_steal_pointer(&buf);
> +
> +    return size;
> +}

This function looks quite wrong to me. Why is there a g_malloc() in here if 
g_file_get_contents() already allocates the memory?

And why do we need a max_size here? If there is a reason, please add a 
proper comment in the source code.

> +#ifdef CONFIG_GNUTLS
> +int g_init_cert(uint8_t *raw_cert, size_t cert_size, gnutls_x509_crt_t *g_cert)

Please don't use a "g_" prefix here - otherwise that way the function could 
be confused with the functions from the glib.

> +{
> +    int rc;
> +
> +    if (gnutls_x509_crt_init(g_cert) < 0) {
> +        return -1;
> +    }
> +
> +    gnutls_datum_t datum_cert = {raw_cert, cert_size};
> +    rc = gnutls_x509_crt_import(*g_cert, &datum_cert, GNUTLS_X509_FMT_DER);
> +    if (rc) {
> +        gnutls_x509_crt_deinit(*g_cert);
> +        return rc;
> +    }
> +
> +    return 0;
> +}
> +#endif /* CONFIG_GNUTLS */
> +
> +static int init_cert_x509_der(size_t size, char *raw, S390IPLCertificate **qcert)

I'd maybe rather use "S390IPLCertificate *" as return type instead of "int" 
and return a NULL in case of errors.

> +{
> +#ifdef CONFIG_GNUTLS
> +    gnutls_x509_crt_t g_cert = NULL;
> +    g_autofree S390IPLCertificate *q_cert;
> +    size_t key_id_size;
> +    size_t hash_size;
> +    int rc;
> +
> +    rc = g_init_cert((uint8_t *)raw, size, &g_cert);
> +    if (rc) {
> +        if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
> +            error_report("The certificate is not in DER format");
> +        }
> +        return -1;
> +    }
> +
> +    rc = gnutls_x509_crt_get_key_id(g_cert, GNUTLS_KEYID_USE_SHA256, NULL, &key_id_size);

Is that documented somewhere that you can call gnutls_x509_crt_get_key_id() 
like this? The docs that I found about this function do not say anything 
about passing NULL here, they rather recommend to use a buffer of size 20 by 
default?

> +    if (rc != GNUTLS_E_SHORT_MEMORY_BUFFER) {
> +        error_report("Failed to get certificate key ID size");
> +        goto out;
> +    }
> +
> +    rc = gnutls_x509_crt_get_fingerprint(g_cert, GNUTLS_DIG_SHA256, NULL, &hash_size);

For this function, the NULL pointer handling is documented, so here it seems 
to be OK.

> +    if (rc != GNUTLS_E_SHORT_MEMORY_BUFFER) {
> +        error_report("Failed to get certificate hash size");
> +        goto out;
> +    }
> +
> +    q_cert = g_malloc(sizeof(*q_cert));

Please use g_new() for allocating memory for structures instead.

> +    q_cert->size = size;
> +    q_cert->key_id_size = key_id_size;
> +    q_cert->hash_size = hash_size;
> +    q_cert->raw = raw;
> +    q_cert->format = GNUTLS_X509_FMT_DER;
> +    *qcert = g_steal_pointer(&q_cert);

If there is no "return" between the allocation and the final "return 0", you 
can also drop the g_autofree and g_steal_pointer from this function.

> +    gnutls_x509_crt_deinit(g_cert);
> +
> +    return 0;
> +out:
> +    gnutls_x509_crt_deinit(g_cert);
> +    return -1;
> +#else
> +    error_report("Cryptographic library is not enabled")
> +    return -1;
> +#endif /* #define CONFIG_GNUTLS */
> +}
> +
> +static int check_path_type(const char *path)
> +{
> +    struct stat path_stat;
> +
> +    stat(path, &path_stat);
> +
> +    if (S_ISDIR(path_stat.st_mode)) {
> +        return S_IFDIR;
> +    } else if (S_ISREG(path_stat.st_mode)) {
> +        return S_IFREG;
> +    } else {
> +        return -1;
> +    }
> +}
> +
> +static int init_cert(char *paths, S390IPLCertificate **qcert)

as with previous function, use "S390IPLCertificate *" as return type instead 
of "int" ?

> +{
> +    char *buf;
> +    char vc_name[VC_NAME_LEN_BYTES];
> +    const gchar *filename;
> +    size_t size;
> +
> +    filename = g_path_get_basename(paths);

g_path_get_basename() returns an allocated string. You've finally got to 
free it again to avoid leaking memory. I'd suggest declaring filename with 
g_autofree.

> +    size = cert2buf(paths, CERT_MAX_SIZE, &buf);
> +    if (size == 0) {
> +        error_report("Failed to load certificate: %s", paths);
> +        return -1;
> +    }
> +
> +    if (init_cert_x509_der(size, buf, qcert) < 0) {
> +        error_report("Failed to initialize certificate: %s", paths);
> +        return -1;
> +    }
> +
> +    /*
> +     * Left justified certificate name with padding on the right with blanks.
> +     * Convert certificate name to EBCDIC.
> +     */
> +    strpadcpy(vc_name, VC_NAME_LEN_BYTES, filename, ' ');
> +    ebcdic_put((*qcert)->vc_name, vc_name, VC_NAME_LEN_BYTES);
> +
> +    return 0;
> +}
> +
> +static void update_cert_store(S390IPLCertificateStore *cert_store,
> +                              S390IPLCertificate *qcert)
> +{
> +    size_t data_size;
> +
> +    data_size = qcert->size + qcert->key_id_size + qcert->hash_size;
> +
> +    if (cert_store->max_cert_size < data_size) {
> +        cert_store->max_cert_size = data_size;
> +    }
> +
> +    cert_store->certs[cert_store->count] = *qcert;
> +    cert_store->total_bytes += data_size;
> +    cert_store->count++;
> +}
> +
> +static GPtrArray *get_cert_paths(void)
> +{
> +    const char *path;
> +    gchar **paths;
> +    int path_type;
> +    GDir *dir = NULL;
> +    const gchar *filename;
> +    GPtrArray *cert_path_builder;
> +
> +    cert_path_builder = g_ptr_array_new();
> +
> +    path = s390_get_boot_certificates();
> +    if (path == NULL) {
> +        return cert_path_builder;
> +    }
> +
> +    paths = g_strsplit(path, ":", -1);

Free the memory that has been allocated by the g_strsplit at the end of the 
function?

> +    while (*paths) {
> +        /* skip empty certificate path */
> +        if (!strcmp(*paths, "")) {
> +            paths += 1;
> +            continue;
> +        }
> +
> +        path_type = check_path_type(*paths);
> +        if (path_type == S_IFREG) {
> +            g_ptr_array_add(cert_path_builder, (gpointer) *paths);

... that should likely g_strdup(*paths) when we want to free paths at the end.

> +        } else if (path_type == S_IFDIR) {
> +            dir = g_dir_open(*paths, 0, NULL);
> +
> +            while ((filename = g_dir_read_name(dir))) {
> +                gchar *cert_path = NULL;
> +                cert_path = g_build_filename(*paths, filename, NULL);
> +                g_ptr_array_add(cert_path_builder, (gpointer) cert_path);
> +            }
> +
> +            g_dir_close(dir);
> +        }
> +
> +        paths += 1;
> +    }
> +
> +    return cert_path_builder;
> +}
> +
> +void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
> +{
> +    GPtrArray *cert_path_builder;
> +
> +    cert_path_builder = get_cert_paths();
> +    if (cert_path_builder->len == 0) {
> +        g_ptr_array_free(cert_path_builder, true);
> +        return;
> +    }
> +
> +    cert_store->max_cert_size = 0;
> +    cert_store->total_bytes = 0;
> +
> +    for (int i = 0; i < cert_path_builder->len; i++) {
> +        S390IPLCertificate *qcert = NULL;
> +        if (init_cert((char *) cert_path_builder->pdata[i], &qcert) < 0) {
> +            continue;

Maybe invert the logic to call update_cert_store() in case of success, than 
you don't need the "continue" anymore?

> +        }
> +
> +        update_cert_store(cert_store, qcert);
> +    }
> +
> +    g_ptr_array_free(cert_path_builder, true);
> +}

  Thomas


